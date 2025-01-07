# Contexto
Servidor para hospedar a plataforma web do *Patas do Cerrado*, um site que será utilizado inicialmente na região do Estado de Goiás.

---

## 1. Planejamento do Hardware
Para o contexto de um servidor Web, a máquina que disponibilizará a plataforma deverá deter os seguintes requisitos mínimos:

- **Processador**: Intel® Xeon® E5-2680 v4
- **Número de núcleos**: 14
- **Total de threads**: 28
- **Frequência max**: 3.30 GHz

- **Memória RAM**: 2x32 DDR4 3000mhz

- **Espaço em Disco**: 1 Terabyte SSD

- **Conexão de rede**: 500 Gbps

- **Motherboard**: X99 MR9S V6  
  - **Processador**: Suporte Intel LGA2011-3  
  - **Memória slot**: 8*240 DDR4  
  - **Capacidade máxima suportada**: 256GB  
  - **Slot placas gráficas**: 3*PCI Express x16

---

## 2. Instalação e Configuração do Sistema Operacional

Para nosso S.O (Sistema Operacional) será utilizado o **Linux**, ao qual é de software livre e disponibiliza diversas distribuições totalmente gratuitas que oferecem segurança e desempenho superiores aos servidores Windows.

### 2.1. Distribuição Selecionada

A distribuição escolhida para hospedar nosso servidor inicialmente, será o **Ubuntu Server 22.04 LTS**.  
A versão **LTS (Long Term Support)** foi escolhida devido à sua estabilidade e suporte estendido, que garante atualizações e correções de segurança por um período de 5 anos.

[Link para download](https://ubuntu.com/download/server)

### 2.2. Requisitos de Hardware
Antes de iniciar a instalação, foram definidos os seguintes requisitos de hardware para garantir o bom funcionamento do servidor, os quais foram mencionados e escolhidos no Planejamento de Hardware.

- **Processador**: Intel® Xeon® E5-2680 v4
- **Número de núcleos**: 14
- **Total de threads**: 28
- **Frequência max**: 3.30 GHz

- **Memória RAM**: 2x32 DDR4 3000mhz

- **Espaço em Disco**: 1 Terabyte SSD

- **Conexão de rede**: 500 Gbps

- **Motherboard**: X99 MR9S V6  
  - **Processador**: Suporte Intel LGA2011-3  
  - **Memória slot**: 8*240 DDR4  
  - **Capacidade máxima suportada**: 256GB  
  - **Slot placas gráficas**: 3*PCI Express x16

### 2.3. Processo de Instalação

1. **Download da Imagem ISO**: A primeira etapa consiste em baixar a imagem ISO do **Ubuntu Server 22.04 LTS** diretamente do site oficial.
2. **Criação de Mídia de Instalação**: Utilizamos uma ferramenta como o **Rufus** para criar um pendrive de inicialização com a imagem ISO.
3. **Instalação do Sistema**: Após inicializar o servidor a partir do pendrive, seguimos os passos do instalador do Ubuntu, onde escolhemos as configurações iniciais:
   - Configuração de rede (definindo IP estático ou DHCP, conforme necessidade).
   - Particionamento do disco rígido (utilizamos a opção de partição padrão para simplificar a instalação).
   - Instalação de pacotes essenciais (como OpenSSH, para acesso remoto ao servidor).
   - Criação de usuário administrador e definição de senha.

### 2.4. Configuração de Rede
Após a instalação, configuramos as interfaces de rede, garantindo que o servidor tenha um endereço IP fixo para facilitar o acesso remoto e a gestão.

### 2.5. Configuração de Segurança e Desempenho

- **Firewall**: O **UFW (Uncomplicated Firewall)** foi habilitado e configurado para permitir apenas tráfego necessário (como SSH na porta 22 e HTTP/HTTPS nas portas 80 e 443).
- **Atualizações Automáticas**: Configuramos o **unattended-upgrades** para garantir que as atualizações de segurança sejam aplicadas automaticamente, mantendo o servidor protegido.
- **Configuração de Swap**: Para otimizar o uso de memória, configuramos uma área de swap em disco, garantindo maior desempenho durante picos de uso de memória.
- **Desabilitação de Serviços Desnecessários**: Desabilitamos serviços que não são essenciais para o funcionamento do servidor, como o Bluetooth ou o servidor gráfico, a fim de reduzir a superfície de ataque e melhorar o desempenho.

### 2.6. Otimização para Hospedagem Web

- **Instalação do Apache e PHP**: Para hospedar o site do Patas do Cerrado, instalamos o **Apache** como servidor web e **PHP** para processar scripts dinâmicos.
- **Banco de Dados MySQL**: Instalamos o **MySQL** para gerenciar o banco de dados do site, garantindo que as tabelas e dados sejam armazenados de forma eficiente e segura.
- **Configuração de SSL**: Para garantir a segurança da comunicação entre o servidor e os visitantes, configuramos o **Certbot** para obter e renovar automaticamente os certificados SSL gratuitos do **Let's Encrypt**.
- **Monitoramento de Desempenho**: Configuramos ferramentas como o **htop** e o **Netdata** para monitorar o desempenho do servidor em tempo real e garantir que o site funcione de maneira eficiente, mesmo durante picos de tráfego.

### 2.7. Backup e Recuperação
Implementamos uma rotina de backups automatizados utilizando o **rsync** para garantir que todos os arquivos essenciais do servidor, incluindo o banco de dados, sejam copiados regularmente para uma unidade externa ou serviço de armazenamento em nuvem.

---

## 3.0. Como Utilizar o Projeto *(Passo a Passo)*

1. **Clone o Repositório**: Primeiramente, faça o clone do repositório a partir do GitHub para o seu ambiente local.
2. **Acesse o Diretório do Projeto**: No terminal, entre na pasta onde o repositório foi clonado e, em seguida, execute o comando `vagrant up` para iniciar a criação das máquinas virtuais.
3. **Verifique o Status das Máquinas Virtuais**: Para acompanhar o status das VMs, utilize o comando `vagrant status`. Isso permitirá que você veja se as VMs foram corretamente criadas.
4. **Acessando as VMs**: Depois de verificar o status, entre em cada uma das VMs usando o comando `vagrant ssh`, seguido do nome da VM (exemplo: `vagrant ssh servicos-vm`).
5. **Desligar ou Apagar as VMs**: Quando terminar, desligue as VMs com o comando `vagrant halt`. Se desejar apagá-las, execute o comando `vagrant destroy`.

### 4.0. Estrutura do Repositório

A organização dos arquivos dentro do projeto é a seguinte:

- **DockerDHCP**
  - *dhcpd.conf*

- **DockerDNS**
  - *example.com.zone*
  - *named.conf*
  - *named.conf.local*
  - *rndc.key*

- **DockerFTP**
  - *vsftpd.conf*

- **DockerNFS**
  - *teste.txt*

- **DockerWeb**
  - *index.html*

- **Provisionadores**
  - *dhcp_provision.sh*
  - *dns_provision.sh*
  - *ftp_provision.sh*
  - *nfs_provision.sh*
  - *web_provision.sh*
  - *vm2_provision.sh*

- **Arquivos de Configuração e Documentação**
  - *Vagrantfile*
  - *README.md*

# Topologia de Rede

A estrutura de rede desenvolvida neste projeto consiste em uma rede privada com duas máquinas virtuais, configuradas de maneira que uma delas utiliza IP estático e a outra obtém seu IP por DHCP. Além disso, todos os containers da rede recebem IP através da máquina virtual configurada com IP fixo.

## Máquinas Virtuais

### VM1 (Gateway)

- **Hostname**: vm1
- **Box**: ubuntu/focal64
- **Memória**: 2048 MB
- **CPUs**: 2
- **Configuração de Rede**:
  - Interface de rede privada com **IP estático**: 192.168.56.10
  - **Port forwarding**: A porta 80 do guest é redirecionada para a porta 8081 no host (192.168.56.10)
  - Compartilhamento de pastas entre a máquina hospedeira e a máquina virtual
  - Provisionamento de serviços diversos para a rede

### VM2 (Cliente)

- **Hostname**: vm2
- **Box**: ubuntu/focal64
- **Memória**: 2048 MB
- **CPUs**: 2
- **Configuração de Rede**:
  - Interface de rede configurada para **obter IP via DHCP**
  - Provisionamento para atualização de pacotes e instalação do pacote **nfs-common**

---

## Descrição da Rede

### Sub-rede da VM1 (Gateway)

- **Interface 1**:
  - Tipo: Rede Privada
  - **Endereço IP**: 192.168.56.10
  - **Máscara de Sub-rede**: /24 (255.255.255.0)

### Sub-rede da VM2 (Cliente)

- **Interface 1**:
  - Tipo: Rede Privada
  - **Endereço IP**: 192.168.56.x (de 0 a 254, exceto o 10, que é reservado para VM1). O IP é atribuído dinamicamente pelo servidor DHCP.
  - **Máscara de Sub-rede**: /24 (255.255.255.0)

# Provisionamento

Os scripts de **provisionamento** de cada VM estão localizados na pasta `provisions`. 

Cada script executa as configurações e a instalação dos serviços necessários para que cada **VM** e **Container** funcione conforme sua função.

## hardeningProvision.sh

- Reforça o firewall com o IPTABLES, restringindo o tráfego ao mínimo necessário.
- Aumenta a segurança do contêiner Docker com ajustes no servidor Apache.
- Configura serviços de rede (Apache e SSH) gerenciados pelo XINETD, com restrições de acesso, horários e limites de recursos.

## webServerProvision.sh

- Instala ferramentas essenciais para o ambiente de desenvolvimento e execução de contêineres.
- Configura um contêiner Docker com o Apache HTTP Server, garantindo que o servidor web esteja funcionando e sincronizado com o diretório /VagrantWeb.
- Realiza uma medida básica de segurança no servidor, desabilitando o login SSH como root, reduzindo o risco de ataques à conta administrativa.



  ## hardeningProvision.sh

- **Firewall**:
  - Reforça o firewall com o IPTABLES.
  - Restringe o tráfego ao mínimo necessário.
- **Segurança do Docker**:
  - Aumenta a segurança do contêiner Docker com ajustes no servidor Apache.
- **Serviços de Rede (Apache e SSH)**:
  - Configurados pelo XINETD.
  - Restrições de acesso, horários e limites de recursos.

## webServerProvision.sh

- **Ferramentas Essenciais**:
  - Instala ferramentas essenciais para o ambiente de desenvolvimento e execução de contêineres.
- **Configuração do Servidor Web**:
  - Configura um contêiner Docker com o Apache HTTP Server.
  - Sincroniza o servidor web com o diretório /VagrantWeb.
- **Segurança Básica**:
  - Desabilita o login SSH como root.
  - Reduz o risco de ataques à conta administrativa.
