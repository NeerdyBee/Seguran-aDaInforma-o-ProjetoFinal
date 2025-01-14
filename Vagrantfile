# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Define a configuração do Vagrant na versão 2
  # Server: Configuração da primeira máquina virtual (VM1)
  config.vm.define "vm1" do |vm1Server|
    vm1Server.vm.hostname = "vm1" # Define o hostname da VM como "vm1"
    vm1Server.vm.box = "ubuntu/focal64" # Especifica a imagem base da VM (Ubuntu 20.04 LTS)
    
    # Configuração do hardware da VM
    vm1Server.vm.provider "virtualbox" do |vb|
      vb.memory = 2048 # Define 2GB de memória para a VM
      vb.cpus = 2 # Define 2 CPUs para a VM
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"] # Garante que o cabo de rede virtual esteja conectado
    end

    # Configuração de rede
    vm1Server.vm.network "public_network", type: "dhcp", ip: "192.168.24.166", bridge: "enp2s0"
    # Define uma rede pública para a VM com um IP fixo (192.168.24.166) e ponte (bridge) na interface "enp2s0"

    vm1Server.vm.synced_folder "./WebServerFiles", "/VagrantWeb"
    # Sincroniza a pasta local "./WebServerFiles" com o diretório "/VagrantWeb" dentro da VM

    vm1Server.vm.network "forwarded_port", guest: 80, host: 8082
    # Redireciona a porta 80 da VM (HTTP) para a porta 8082 no host

    vm1Server.vm.network "forwarded_port", guest: 22, host: 2222
    # Redireciona a porta 22 da VM (SSH) para a porta 2222 no host

    # Provisionamento: Execução de scripts após o início da VM
    vm1Server.vm.provision "shell", path: "provisions/webServerProvision.sh"
    # Executa o script "webServerProvision.sh" para configurar o servidor web e seus serviços

    vm1Server.vm.provision "shell", path: "provisions/hardeningProvision.sh"
    # Executa o script "hardeningProvision.sh" para implementar medidas de segurança na VM
  end

  # Teste: Configuração da segunda máquina virtual (VM2)
  config.vm.define "vm2" do |vm2Teste|
    vm2Teste.vm.hostname = "vm2" # Define o hostname da VM como "vm2"
    vm2Teste.vm.box = "ubuntu/focal64" # Especifica a imagem base da VM (Ubuntu 20.04 LTS)

    # Configuração do hardware da VM
    vm2Teste.vm.provider "virtualbox" do |vb|
      vb.memory = 2048 # Define 2GB de memória para a VM
      vb.cpus = 2 # Define 2 CPUs para a VM
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"] # Garante que o cabo de rede virtual esteja conectado
    end

    vm2Teste.vm.network "public_network", type: "dhcp", bridge: "enp2s0"
    # Define uma rede pública para a VM, com atribuição dinâmica de IP (via DHCP) na interface "enp2s0"

    vm2Teste.vm.provision "shell", path: "provisions/VM2Provisions.sh"
    # Executa o script "VM2Provisions.sh" para configurar e instalar pacotes necessários na VM2
  end
end

