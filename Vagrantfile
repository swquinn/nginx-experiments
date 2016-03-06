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

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# The name of the file used for configuration overrides.
VAGRANTFILE_JSON_PROPERTIES_OVERRIDE = "vagrant.json"

# Add "deep_merge" functionality to Hash
class ::Hash
    def deep_merge(second)
        merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
        self.merge(second, &merger)
    end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  #: The default properties that will be used for parts of the VM configuration,
  #: this should contain all of the sensible defaults to the values which we are
  #: allowing developers to override.
  props = {
    "network" => {
      "ip"            => "dhcp",
    }
  }

  #: Check to see if the file exists, if it does attempt to open, read, and parse
  #: it. If it is parsed the contents will be merged with the default properties
  #: overriding them.
  if File::exists?(VAGRANTFILE_JSON_PROPERTIES_OVERRIDE)
    file = open(VAGRANTFILE_JSON_PROPERTIES_OVERRIDE)
    begin
      json = file.read
      overrides = JSON.parse(json)
      props = props.deep_merge(overrides)
    rescue
      print "Vagrant encountered an error while attempting to parse: "+VAGRANTFILE_JSON_PROPERTIES_OVERRIDE
    ensure
      file.close unless file.nil?
    end
  end

  #############################################################################
  ## VAGRANT BOX ENVIRONMENT CONFIGURATION
  #############################################################################

  #: SHARED FOLDERS:
  #:
  #: Create shared folders for Vagrant to interact with.
  #:
  #: The Lorecall server relies on a application files being accessible and
  #: located in a well defined directory (i.e. under /usr/share/extesla). By
  #: default, we always mount the project under the /vagrant directory using
  #: a basic shared folder.
  #:
  #: Basic folder sharing is generally not very efficient--particularly when a
  #: project contains a large number of files in subdirectories. The type of
  #: share used for the non /vagrant folder share can be configured within the
  #: vagrant.json manifest file.
  config.vm.synced_folder ".", "/vagrant"

  #: Provision the networking.
  config.vm.network :private_network, ip: props["network"]["ip"]

  #: Provision the bare-metal box.
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, path: "initctl.sh"

  #: Provision docker, images, etc.
  config.vm.provision :docker do |docker|
    docker.pull_images "ubuntu"
  end

  config.vm.provision :shell, path: "provision.sh"

end
