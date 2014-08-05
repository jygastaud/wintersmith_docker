# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "phusion/ubuntu-14.04-amd64"
  #config.vm.network "forwarded_port", guest: 49160, host: 8123

  # Loop forwarded_port
  #for i in 8000..8050
  #    config.vm.network :forwarded_port, guest: i, host: i
  #end

  config.vm.provision "shell", path: "settings/setup.sh"

end
