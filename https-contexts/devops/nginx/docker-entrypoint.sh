#!/bin/bash
# Copyright 2012 Extesla Digital Entertainment, Ltd.. All rights reserved.
#
# It is illegal to use, reproduce or distribute any part of this
# Intellectual Property without prior written authorization from
# Extesla Digital Entertainment, Ltd..
set -e

#: The location of the NGINX sites-available directory
SITES_AVAILABLE_DIR=/etc/nginx/sites-available

#: The location of the NGINX sites-enabled directory
SITES_ENABLED_DIR=/etc/nginx/sites-enabled

ENTRYPOINT=/usr/bin/supervisord
HTTPDUSER="www-data"
WWW_DIR=/var/www

#: <summary>
#: Log a message to the console.
#: </summary>
#: <param name="message" position="$1">The message</param>
function log {
  message=$1
  time=$(date +"%F %T,%3N")
  #echo -e $time $1; tput sgr0
  echo -e $time $1
}


#: <summary>
#: Create symlinks in sites-enabled to all of the files in the sites-available
#: directory.
#: </summary>
function enable_available_sites {

  #: Iterate over all of the files in the sites-available directory (both at
  #: the root level of the directory and one level below) and enable every
  #: configuration file that you find.
  for path in $(find $SITES_AVAILABLE_DIR -iname "*.conf" -maxdepth 2 -mindepth 1 -type f); do
    local directory=${path%/*}
    local file=${path##*/}
    local link=$SITES_ENABLED_DIR/$file
    log "[INFO ] Enabling site: \033[0;33m$path\033[0m"
    log "[DEBUG] \033[0;32m$ ln -s $path $link\033[0m"
    ln -s $path $link
  done
}

#: <summary>
#: Assigns  environment variables to the colleciton of environment variables
#: accessible to nginx by altering the /etc/php5/fpm/pool.d/www.conf file.
#: If an environment variable already exists, this method will replace the
#: value (provided the variable is set), otherwise it will add a new entry
#: into the www.conf file.
#: </summary>
function setEnvironmentVariable {
    # Check the value, if it isn't set, warn and abort.
    if [ -z "$2" ]; then
      echo -e "[WARN ] Unable to assign variable '$1'; no value set."
      return
    fi
    # Check whether variable already exists
    if grep -q $1 /etc/php5/fpm/pool.d/www.conf; then
      # Reset variable
      echo -e "[INFO ] Resetting environment variable '$1': env[$1] = $2"

      safe_key=$(printf '%s\n' "$1" | sed 's/[\&/]/\\&/g')
      safe_val=$(printf '%s\n' "$2" | sed 's/[\&/]/\\&/g')
      echo -e "[DEBUG] > sed -i "s/^env\[${safe_key}.*/env\[${safe_key}\] = ${safe_val}/g" /etc/php5/fpm/pool.d/www.conf"
      sed -i "s/^env\[${safe_key}.*/env\[${safe_key}\] = ${safe_val}/g" /etc/php5/fpm/pool.d/www.conf
    else
      # Add variable
      echo -e "[INFO ] Adding environment variable '$1': env[$1] = $2"
      echo "env[$1] = $2" >> /etc/php5/fpm/pool.d/www.conf
    fi
}

#: <summary>
#: Updates the cache directory ACL for the passed user and directory.
#: </summary>
#: <param name="$1">the user</param>
#: <param name="$2">the directory</param
function update_acl {
  sudo setfacl  -R -m u:"$1":rwX,u:`whoami`:rwX,mask::rwX $2
  sudo setfacl -dR -m u:"$1":rwX,u:`whoami`:rwX,mask::rwX $2
}

#: Enable all available sites.
enable_available_sites

log "[INFO ] Starting container."
log "[INFO ] $(date +'%b %d, %Y %H:%M:%S %z (%l:%M:%S %p %Z)')"
log "[DEBUG] \033[0;32m$ $ENTRYPOINT $@\033[0m"
$ENTRYPOINT "$@"
