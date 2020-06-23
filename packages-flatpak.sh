#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

FLATPAK_PACKAGES=(
  com.spotify.Client
  com.getpostman.Postman
  com.transmissionbt.Transmission
  com.calibre_ebook.calibre
  com.meetfranz.Franz
  com.sublimetext.three
  org.videolan.VLC
  org.libreoffice.LibreOffice
  us.zoom.Zoom
)

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

echo -e "\n${TITLE_COLOR}Habilitando pacotes Flatpak${NC}"
apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for PACKAGE in ${FLATPAK_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote FLATPAK ${PACKAGE}${NC}"
  flatpak install flathub ${PACKAGE} -y
done

echo -e "\nDone...\n"
