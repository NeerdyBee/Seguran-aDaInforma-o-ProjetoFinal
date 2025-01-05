# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "vmServerProjeto" do |vmServer|
    vmServer.vm.hostname = "vmServerProjeto"
    vmServer.vm.box = "ubuntu/focal64"
    vmServer.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    vmServer.vm.network "public_network", type: "dhcp", ip: "192.168.56.10", bridge: "enp2s0"
    vmServer.vm.synced_folder "./WebServerFiles", "/VagrantWeb"
    vmServer.vm.network "forwarded_port", guest: 80, host: 8081
    vmServer.vm.network "forwarded_port", guest: 31, host: 3311
    vmServer.vm.provision "shell", path: "provisions/hardeningProvision.sh"
    vmServer.vm.provision "shell", path: "provisions/webServerProvision.sh"
  end
end 