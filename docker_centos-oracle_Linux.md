# Docker nas principais Distros Linux

## [Red Hat](https://docs.docker.com/engine/install/rhel/):

Instalar utilitários yum:  

```bash
sudo yum install -y yum-utils
```

Adicionar repositório no Red Hat  

```
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
```

Instalar pacotes Docker no Red Hat  

```bash
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## [CentOS](https://docs.docker.com/engine/install/centos/):  

Instalar utilitários yum:  

```bash
sudo yum install -y yum-utils
```

Adicionar repositório no CentOS   

```
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

Instalar pacotes Docker no CentOS   

```bash
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## [Oracle Linux](https://blogs.oracle.com/virtualization/post/install-docker-on-oracle-linux-7):  

Configurar repositório developer:  
>Oracle Linux 7

```bash
echo -e '[ol7_developer]
name=Oracle Linux $releasever Developer ($basearch)
baseurl=https://yum$ociregion.$ocidomain/repo/OracleLinux/OL7/developer/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
' | sudo tee /etc/yum.repos.d/oraclelinux-developer-ol7.repo >> /dev/null
```

Instalar dependências e desativar repositório developer:  

```bash
sudo yum -y install container-selinux slirp4netns fuse-overlayfs
sudo yum-config-manager --disable ol7_developer
```

Instalar o Docker:  

```bash
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
## [Debian](https://docs.docker.com/engine/install/debian/)

Adicione a chave GPG oficial do Docker:

```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Adicione o repositório aos fontes do Apt:  
>O `sudo` **deve** estar ativado  

```
echo -e "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Para instalar a versão mais recente, execute:  

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Verifique se a instalação foi bem-sucedida executando a imagem `hello-world`:  

```
sudo docker run hello-world
```

## Docker instalado  

Adicionar o usuário ao grupo `docker`:  

```
sudo usermod -aG docker ${USER}
```

Ativar serviço:

```bash
sudo systemctl enable --now docker
systemctl status docker
```

Configurar o soquete docker para o usuário:  

```
sudo chmod 666 /var/run/docker.sock
```

### Comando docker-compose

Verificar se o comando `compose` está em **/usr/bin**:

```bash
ls -l /usr/bin/docker-compose
```
Se não estiver na pasta, faça um link:

```bash
ln -sf /usr/libexec/docker/cli-plugins/docker-compose /usr/bin/
```

Testar o Docker Compose:  

```
docker compose version
```
Testar Docker:  

```
docker info
```

Fontes:  

https://blogs.oracle.com/virtualization/post/install-docker-on-oracle-linux-7  
https://geekscircuit.com/how-to-install-docker-on-oracle-linux-8-7/  
https://docs.docker.com/engine/install/centos/  
https://github.com/denven/Bash-Scripts/blob/master/install_docker_on_oracle_linux_7.9.sh  
