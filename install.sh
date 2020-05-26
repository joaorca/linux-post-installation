#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

DEB_PACKAGES=(
 "google-chrome;https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
 "vscode;https://go.microsoft.com/fwlink/?LinkID=760868"
 "insync;https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.1.8.40816-bionic_amd64.deb"
 "stacer;https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb"
 "franz;https://github.com/meetfranz/franz/releases/download/v5.3.3/franz_5.3.3_amd64.deb"
 )

URL_JETBRAINS="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5796.tar.gz"

APT_PACKAGES=(
  vim
  git
  zsh 
  curl 
  vlc 
  remmina 
  conky 
  tmux 
  baobab 
  htop 
  sysstat 
  glances 
  hddtemp
  snapd
  calibre
  locate
  flameshot
  transmission
  breeze-cursor-theme 
  ubuntu-restricted-extras 
  libavcodec-extra 
  gnome-tweaks 
  gnome-sushi 
)

SNAP_PACKAGES=(
  spotify
  postman
  libreoffice
)

#SNAP_PACKAGES_REMOVE=(
#  gnome-calculator 
#  gnome-characters 
#  gnome-logs 
#  gnome-system-monitor
#)

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

echo -e "\n${TITLE_COLOR}Removendo pacotes não usados${NC}"
apt autoremove -y

for DEB_PACKAGE in ${DEB_PACKAGES[@]} 
do
  IFS=";" 
  read -ra PACKAGE <<< "${DEB_PACKAGE}"
  echo -e "\n${TITLE_COLOR}Instalando pacote DEB ${PACKAGE[0]}${NC}"
  if ! dpkg -l | grep -q ${PACKAGE[0]}; then
    if ! [ -f /tmp/${PACKAGE[0]}.deb ]; then
      wget ${PACKAGE[1]} -O /tmp/${PACKAGE[0]}.deb 
    fi
    dpkg -i /tmp/${PACKAGE[0]}.deb
    apt --fix-broken install -y
  else
    echo -e "${PACKAGE[0]} já instalado"
  fi
  IFS=" "
done

echo -e "\n${TITLE_COLOR}Instalando JetBrains-Toolbox${NC}"
if ! [ -f /opt/jetbrains-toolbox/jetbrains-toolbox ]; then
  wget ${URL_JETBRAINS} -O /tmp/jetbrains-toolbox.tar.gz && \
    tar -zxf /tmp/jetbrains-toolbox.tar.gz -C /tmp && \
    mkdir -p /opt/jetbrains-toolbox && \
    mv /tmp/jetbrains-toolbox*/jetbrains-toolbox /opt/jetbrains-toolbox/jetbrains-toolbox && \
    chmod 0777 /opt/jetbrains-toolbox
else
  echo -e "${PACKAGE[0]} já instalado"
fi

for PACKAGE in ${APT_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote APT ${PACKAGE}${NC}"
  apt install -y ${PACKAGE} >/dev/null
done

for PACKAGE in ${SNAP_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote SNAP ${PACKAGE}${NC}"
  snap install ${PACKAGE}
done

#for PACKAGE in ${SNAP_PACKAGES_REMOVE[@]}
#do
#  echo -e "\n${TITLE_COLOR}Removendo SNAP ${PACKAGE}${NC}"
#  snap remove  ${PACKAGE}
#done

#echo -e "\n${TITLE_COLOR}Habilitando pacotes Flatpak${NC}"
#apt install -y flatpak gnome-software-plugin-flatpak
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "\n${TITLE_COLOR}Corrigindo dependencias${NC}"
apt --fix-broken install -y

apt dist-upgrade -y

echo -e "\n${TITLE_COLOR}Limpeza de pacotes${NC}"
apt autoclean
apt autoremove -y

echo -e "\nDone...\n"
