#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

DEB_PACKAGES=(
 "insync;https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.3.3.40905-focal_amd64.deb"
)

APT_PACKAGES=(
  vim
  zsh
  conky 
  remmina
  tmux 
  baobab 
  htop 
  sysstat 
  glances 
  hddtemp
  stacer
  locate
  flameshot
  breeze-cursor-theme 
  ubuntu-restricted-extras 
  libavcodec-extra 
  gnome-tweaks 
  gnome-sushi
  google-chrome-stable
  network-manager-openvpn-gnome
)

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

echo -e "\n${TITLE_COLOR}Atualizando pacotes${NC}"
rm -f /var/lib/dpkg/lock-frontend
rm -f /var/cache/apt/archives/lock
apt update -y

echo -e "\n${TITLE_COLOR}Atualizando sistema${NC}"
apt upgrade -y
apt dist-upgrade -y

for DEB_PACKAGE in ${DEB_PACKAGES[@]} 
do
  IFS=";" 
  read -ra PACKAGE <<< "${DEB_PACKAGE}"
  echo -e "\n${TITLE_COLOR}Instalando pacote DEB ${PACKAGE[0]}${NC}"
  if ! dpkg -l | grep -q ${PACKAGE[0]}; then
    if ! [ -f /tmp/${PACKAGE[0]}.deb ]; then
      wget -q ${PACKAGE[1]} -O /tmp/${PACKAGE[0]}.deb --show-progress
    fi
    dpkg -i /tmp/${PACKAGE[0]}.deb
    apt --fix-broken install -y
  else
    echo -e "${PACKAGE[0]} já instalado"
  fi
  IFS=" "
done

for PACKAGE in ${APT_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote APT ${PACKAGE}${NC}"
  apt install -y ${PACKAGE}
done

echo -e "\n${TITLE_COLOR}Instalando pacote YouTube-DL${NC}"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

echo -e "\n${TITLE_COLOR}Corrigindo dependencias${NC}"
apt --fix-broken install -y

echo -e "\n${TITLE_COLOR}Limpeza de pacotes${NC}"
apt autoclean
apt autoremove -y

echo -e "\nDone...\n"