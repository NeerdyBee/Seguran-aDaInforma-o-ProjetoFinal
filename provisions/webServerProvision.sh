#!/bin/bash

# -- Linhas de execução para instalação das ferramentas necessárias para executar o Container Web Apache
apt update
apt install -y docker.io vim curl wget git
docker pull httpd

sudo docker run -d -v /VagrantWeb:/usr/local/apache2/htdocs/ --restart always --name web -p 80:80 httpd

sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd