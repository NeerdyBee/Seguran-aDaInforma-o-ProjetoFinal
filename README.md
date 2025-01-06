Contexto: Servidor para hospedar a plataforma web do Patas do Cerrado, um site que será utilizado inicialmente na região do Estado de Goiás.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**1. Planejamento do Hardware**
Para o contexto de um servidor Web, a máquina que disponibilizará a plataforma deverá deter os seguintes requisitos mínimos:

- Processador: Intel® Xeon® E5-2680 v4
- Número de núcleos: 14
- Total de threads: 28
- Frequência max: 3.30 GHz

- Memória RAM: 2x32 DDR4 3000mhz

- Espaço em Disco: 1 Terabyte SSD

- Conexão de rede: 500 Gbps 

Motherboard: X99 MR9S V6
		Processador: Suporte Intel LGA2011-3
		Memória slot: 8*240 DDR4
		Capacidade máxima suportada: 256GB
		Slot placas gráficas: 3*PCI Express x16



**2. Instalação e Configuração do Sistema Operacional**

Para nosso S.O (Sistema Operacional) será utilizado o Linux ao qual é de software livre e que disponibiliza diversas distribuições totalmente gratuitas que oferecem segurança e desempenho superiores aos servidores Windows.

2.1 Distribuição Selecionada

A distribuição escolhida para hospedar nosso servidor inicialmente, será o Ubuntu Server 22.04 LTS. 
A versão LTS (Long Term Support) foi escolhida devido a estabilidade e suporte estendido, que vai nos garantir atualizações e correções de segurança por um período de 5 anos.

Link: https://ubuntu.com/download/server



2.2. Requisitos de Hardware
Antes de iniciar a instalação, foram definidos os seguintes requisitos de hardware para garantir o bom funcionamento do servidor, os quais foram mencionados e escolhidos no Planejamento de Hardware.
Processador: Intel® Xeon® E5-2680 v4
Número de núcleos: 14
Total de threads: 28
Frequência max: 3.30 GHz

Memória RAM: 2x32 DDR4 3000mhz

Espaço em Disco: 1 Terabyte SSD

Conexão de rede: 500 Gbps 

Motherboard: X99 MR9S V6
		Processador: Suporte Intel LGA2011-3
		Memória slot: 8*240 DDR4
		Capacidade máxima suportada: 256GB
		Slot placas gráficas: 3*PCI Express x16


2.3. Processo de Instalação
Download da Imagem ISO: A primeira etapa consiste em baixar a imagem ISO do Ubuntu Server 22.04 LTS diretamente do site oficial.

Criação de Mídia de Instalação: Utilizamos uma ferramenta como o Rufus para criar um pendrive de inicialização com a imagem ISO.

Instalação do Sistema: Após inicializar o servidor a partir do pendrive, seguimos os passos do instalador do Ubuntu, onde escolhemos as configurações iniciais:

Configuração de rede (definindo IP estático ou DHCP, conforme necessidade).

Particionamento do disco rígido (utilizamos a opção de partição padrão para simplificar a instalação).

Instalação de pacotes essenciais (como OpenSSH, para acesso remoto ao servidor).

Criação de usuário administrador e definição de senha.


2.4. Configuração de Rede
Após a instalação, configuramos as interfaces de rede, garantindo que o servidor tenha um endereço IP fixo para facilitar o acesso remoto e a gestão.

2.5. Configuração de Segurança e Desempenho

Firewall: O UFW (Uncomplicated Firewall) foi habilitado e configurado para permitir apenas tráfego necessário (como SSH na porta 22 e HTTP/HTTPS nas portas 80 e 443).
Atualizações Automáticas: Configuramos o unattended-upgrades para garantir que as atualizações de segurança sejam aplicadas automaticamente, mantendo o servidor protegido.
Configuração de Swap: Para otimizar o uso de memória, configuramos uma área de swap em disco, garantindo maior desempenho durante picos de uso de memória.
Desabilitação de Serviços Desnecessários: Desabilitamos serviços que não são essenciais para o funcionamento do servidor, como o Bluetooth ou o servidor gráfico, a fim de reduzir a superfície de ataque e melhorar o desempenho.



2.6. Otimização para Hospedagem Web

Instalação do Apache e PHP: Para hospedar o site do Patas do Cerrado, instalamos o Apache como servidor web e PHP para processar scripts dinâmicos.
Banco de Dados MySQL: Instalamos o MySQL para gerenciar o banco de dados do site, garantindo que as tabelas e dados sejam armazenados de forma eficiente e segura.
Configuração de SSL: Para garantir a segurança da comunicação entre o servidor e os visitantes, configuramos o Certbot para obter e renovar automaticamente os certificados SSL gratuitos do Let's Encrypt.
Monitoramento de Desempenho: Configuramos ferramentas como o htop e o Netdata para monitorar o desempenho do servidor em tempo real e garantir que o site funcione de maneira eficiente, mesmo durante picos de tráfego.

2.7. Backup e Recuperação
Implementamos uma rotina de backups automatizados utilizando o rsync para garantir que todos os arquivos essenciais do servidor, incluindo o banco de dados, sejam copiados regularmente para uma unidade externa ou serviço de armazenamento em nuvem.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


**3.0. Como Utilizar o Projeto**

1. Clone o Repositório: Primeiramente, faça o clone do repositório a partir do GitHub para o seu ambiente local.
2. Acesse o Diretório do Projeto: No terminal, entre na pasta onde o repositório foi clonado e, em seguida, execute o comando vagrant up para iniciar a criação das máquinas virtuais.
3. Verifique o Status das Máquinas Virtuais: Para acompanhar o status das VMs, utilize o comando vagrant status. Isso permitirá que você veja se as VMs foram corretamente criadas.
4 Acessando as VMs: Depois de verificar o status, entre em cada uma das VMs usando o comando vagrant ssh, seguido do nome da VM (exemplo: vagrant ssh servicos-vm).
5. Desligar ou Apagar as VMs: Quando terminar, desligue as VMs com o comando vagrant halt. Se desejar apagá-las, execute o comando vagrant destroy.

Estrutura do Repositório
A organização dos arquivos dentro do projeto é a seguinte:

DockerDHCP
  - *dhcpd.conf*

  DockerDNS
  - *example.com.zone*
  - *named.conf*
  - *named.conf.local*
  - *rndc.key*

  DockerFTP
  - *vsftpd.conf*

  DockerNFS
  - *teste.txt*

  DockerWeb
  - *index.html*

  Provisionadores
  - *dhcp_provision.sh*
  - *dns_provision.sh*
  - *ftp_provision.sh*
  - *nfs_provision.sh*
  - *web_provision.sh*
  - *vm2_provision.sh*

  Arquivos de Configuração e Documentação
  - *Vagrantfile*
  - *README.md*



