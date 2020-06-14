#!/usr/bin/env bash

YELLOW="\033[1;33m"; RED="\033[0;31m"; ENDCOLOR="\033[0m"

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

echo -e "\n${YELLOW}install packages to allow apt to use a repository over HTTPS${ENDCOLOR}"

apt install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

echo -e "\n${YELLOW}Add Docker’s official GPG key${ENDCOLOR}"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

echo -e "\n${YELLOW}Set up the stable repository${ENDCOLOR}"
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


echo -e "\n${YELLOW}Install the latest version of Docker Engine and containerd${ENDCOLOR}"
apt update
apt install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo ""
read -p "Enter your username: " USERNAME
if [ "$USERNAME" != "" ] ; then
    echo -e "\nHello, ${GREEN}$USERNAME${NC}!\n"
    usermod -aG docker $USERNAME
fi



# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
# sudo usermod -aG docker your-user
