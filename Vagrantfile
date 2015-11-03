# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.network "private_network", ip: "192.168.40.2"
  
  config.vm.box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
  config.vm.hostname = "emoncms.dev"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # end with error message "stdin: is not a tty"

  config.vm.synced_folder ".", "/home/vagrant/host", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provision "shell", path: "provision.sh"

end