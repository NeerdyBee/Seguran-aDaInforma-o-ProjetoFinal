# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    #Server
    config.vm.define "vm1" do |vm1Server|
      vm1Server.vm.hostname = "vm1"
      vm1Server.vm.box = "ubuntu/focal64"
      vm1Server.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end
      vm1Server.vm.network "public_network", type: "dhcp", ip: "192.168.56.10", bridge: "enp2s0"
      vm1Server.vm.synced_folder "./WebServerFiles", "/VagrantWeb"
      vm1Server.vm.network "forwarded_port", guest: 80, host: 8080
      vm1Server.vm.network "forwarded_port", guest: 22, host: 2222
      vm1Server.vm.provision "shell", path: "provisions/web_provision.sh"
      vm1Server.vm.provision "shell", path: "provisions/hardening.sh"
    end
    #Teste
    config.vm.define "vm2" do |vm2Teste|
      vm2Teste.vm.hostname = "vm2"
      vm2Teste.vm.box = "ubuntu/focal64"
      vm2Teste.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end
        vm2Teste.vm.network "public_network", type: "dhcp", ip: "192.168.56.12", bridge: "enp2s0"
        vm2Teste.vm.provision "shell", path: "provisions/VM2Provisions.sh"
    end
  end 
