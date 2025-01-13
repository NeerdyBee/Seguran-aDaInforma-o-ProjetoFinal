#!/bin/bash

# -- Instalação das ferramentas necessárias para o Hardening
apt-get update -y
apt-get install -y iptables ssh curl wget xinetd

# -- Configuração do firewall (iptables)
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT 
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT 
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT 
iptables -A INPUT -i lo -j ACCEPT  
iptables -A OUTPUT -o lo -j ACCEPT
mkdir -p /etc/iptables
touch /etc/iptables/rules.v4
iptables-save > /etc/iptables/rules.v4

# -- Configuração do Container Apache
sudo docker exec -it web bash -c "
apt-get update -y && apt-get install -y vim
sed -i 's/Options Indexes/Options -Indexes/' /usr/local/apache2/conf/httpd.conf
echo '
<IfModule mod_ssl.c>
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
</IfModule>' >> /usr/local/apache2/conf/httpd.conf
echo 'Header always set X-Content-Type-Options "nosniff"' >> /usr/local/apache2/conf/httpd.conf
echo 'Header always set X-Frame-Options "DENY"' >> /usr/local/apache2/conf/httpd.conf
"
docker restart web

# Hardening XINETD:
# XINETD Apache
echo 'includedir /etc/xinetd.d' >> /etc/xinetd.conf
echo "service apache" >> /etc/xinetd.d/apache
echo "{" >> /etc/xinetd.d/apache
echo "    disable         = no" >> /etc/xinetd.d/apache
echo "    socket_type     = stream" >> /etc/xinetd.d/apache
echo "    wait            = no" >> /etc/xinetd.d/apache
echo "    server          = /usr/sbin/httpd" >> /etc/xinetd.d/apache
echo "    server          = /usr/bin/docker server_args = exec -i web /usr/sbin/httpd -DFOREGROUND" >> /etc/xinetd.d/apache
echo "    log_on_failure  += USERID" >> /etc/xinetd.d/apache
echo "    log_on_success  += PID HOST DURATION" >> /etc/xinetd.d/apache
echo "    only_from       = 192.168.56.0/24" >> /etc/xinetd.d/apache
echo "    no_access       = 0.0.0.0/0" >> /etc/xinetd.d/apache
echo "    access_times    = 09:00-18:00" >> /etc/xinetd.d/apache
echo "    port            = 80" >> /etc/xinetd.d/apache
echo "    cps             = 50 10" >> /etc/xinetd.d/apache
echo "    instances       = 10" >> /etc/xinetd.d/apache
echo "    per_source      = 5" >> /etc/xinetd.d/apache
echo "    rlimit_as       = 64M" >> /etc/xinetd.d/apache
echo "    rlimit_cpu      = 10" >> /etc/xinetd.d/apache
echo "    rlimit_data     = 32M" >> /etc/xinetd.d/apache
echo "    rlimit_rss      = 32M" >> /etc/xinetd.d/apache
echo "    rlimit_stack    = 16M" >> /etc/xinetd.d/apache
echo "    rlimit_nofile   = 1024" >> /etc/xinetd.d/apache
echo "    nice            = 10" >> /etc/xinetd.d/apache
echo "}" >> /etc/xinetd.d/apache


# XINETD SSH
echo "service ssh" >> /etc/xinetd.d/ssh
echo "{" >> /etc/xinetd.d/ssh
echo "    disable         = no" >> /etc/xinetd.d/ssh
echo "    socket_type     = stream" >> /etc/xinetd.d/ssh
echo "    wait            = no" >> /etc/xinetd.d/ssh
echo "    user            = root" >> /etc/xinetd.d/ssh
echo "    server          = /usr/sbin/sshd" >> /etc/xinetd.d/ssh
echo "    server_args     = -i" >> /etc/xinetd.d/ssh
echo "    port            = 22" >> /etc/xinetd.d/ssh
echo "    log_on_failure  += USERID" >> /etc/xinetd.d/ssh
echo "    log_on_success  += PID HOST DURATION" >> /etc/xinetd.d/ssh
echo "    only_from       = 192.168.1.0/24" >> /etc/xinetd.d/ssh
echo "    no_access       = 0.0.0.0/0" >> /etc/xinetd.d/ssh
echo "    instances       = 10" >> /etc/xinetd.d/ssh
echo "    per_source      = 5" >> /etc/xinetd.d/ssh
echo "    rlimit_as       = 64M" >> /etc/xinetd.d/ssh
echo "    rlimit_cpu      = 10" >> /etc/xinetd.d/ssh
echo "    rlimit_data     = 32M" >> /etc/xinetd.d/ssh
echo "    rlimit_rss      = 32M" >> /etc/xinetd.d/ssh
echo "    rlimit_stack    = 16M" >> /etc/xinetd.d/ssh
echo "    rlimit_nofile   = 1024" >> /etc/xinetd.d/ssh
echo "    nice            = 10" >> /etc/xinetd.d/ssh
echo "}" >> /etc/xinetd.d/ssh
service xinetd restart
