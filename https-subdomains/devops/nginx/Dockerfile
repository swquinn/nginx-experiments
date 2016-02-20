# The MIT License (MIT)
#
# Copyright (c) 2016 Sean Quinn
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
FROM ubuntu:trusty
MAINTAINER "Sean Quinn <sean.quinn@extesla.com>"

RUN apt-get update
RUN apt-get -y install acl ack-grep bash-completion curl language-pack-en memcached openssh-server

#: Add Nginx to the list of repos so that we can add it.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list

#: Install and configure Nginx; we need to instruct Nginx to turn the daemon
#: off but we also need to
RUN apt-get -y install nginx && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

#: Install and configure supervisor
RUN apt-get -y install supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf
ADD files/etc/supervisor/conf.d/memcached.conf /etc/supervisor/conf.d/memcached.conf
ADD files/etc/supervisor/conf.d/nginx.conf /etc/supervisor/conf.d/nginx.conf

#: Configure Nginx:
#:
#:   1. Modify the user under which nginx runs from "nginx" to "www-data"
#:
#:   2. Modify worker processes so that it automatically detects the proper
#:      number of processes.
#:
#:   3. Create the variable lib directory for nginx, and give ownership of that
#:      directory to the user "www-data"
RUN sed -i 's/^user\s*nginx;$/user www-data;/' /etc/nginx/nginx.conf && \
    sed -i 's/^worker_processes\s*1;$/worker_processes auto;\nworker_rlimit_nofile 32768;/' /etc/nginx/nginx.conf && \
    sed -i 's/^\s*worker_connections\s*1024;$/  worker_connections 4096;\n  use epoll;\n  multi_accept on;/' /etc/nginx/nginx.conf && \
    sed -i 's/\"\$http_x_forwarded_for\"/\"\$http_x_forwarded_for\" \(\$request_time\)/' /etc/nginx/nginx.conf && \
    sed -i 's/^\s*access_log.*main;$/    access_log \/var\/log\/nginx\/access.log main buffer=16k;/' /etc/nginx/nginx.conf && \
    mkdir -p /var/lib/nginx && \
    chown -R www-data:www-data /var/lib/nginx

#: Define mountable directories.
#VOLUME ["/etc/nginx/sites-available", "/var/log", "/var/www"]

#: Install tools for development and debugging, these may be unnecessary once the
#: container is "perfected"
RUN apt-get -y install nano git

# Define working directory.
WORKDIR /var/www

# Expose ports.
EXPOSE 22
EXPOSE 80
EXPOSE 443

# Define default command.
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
