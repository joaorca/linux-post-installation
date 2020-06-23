#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

SNAP_PACKAGES=(
  spotify
  postman
  libreoffice
  sublime-text
  youtube-dl
)

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

echo -e "\n${TITLE_COLOR}Instalando pacote APT snapd${NC}"
apt install -y snapd >/dev/null

for PACKAGE in ${SNAP_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote SNAP ${PACKAGE}${NC}"
  snap install ${PACKAGE}
done

echo -e "\nDone...\n"
