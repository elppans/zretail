# Docker no CentOS/Oracle Linux


### Adicionar repositório:

```bash
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### Instalação do pacote:

#### CentOS:

```bash
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### Oracle Linux 7:

Configurar repositório developer:

```bash
echo -e '[ol7_developer]
name=Oracle Linux $releasever Developer ($basearch)
baseurl=https://yum$ociregion.$ocidomain/repo/OracleLinux/OL7/developer/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
' | tee /etc/yum.repos.d/oraclelinux-developer-ol7.repo >> /dev/null
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

### Ativar serviço:

```bash
sudo systemctl enable --now docker
systemctl status docker
docker info
```

Fontes:  

https://blogs.oracle.com/virtualization/post/install-docker-on-oracle-linux-7  
https://geekscircuit.com/how-to-install-docker-on-oracle-linux-8-7/  
https://docs.docker.com/engine/install/centos/  
https://github.com/denven/Bash-Scripts/blob/master/install_docker_on_oracle_linux_7.9.sh  
