#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

APT_PACKAGES=(
  vlc
  calibre
  transmission
)

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

for PACKAGE in ${APT_PACKAGES[@]}
do
  echo -e "\n${TITLE_COLOR}Instalando pacote APT ${PACKAGE}${NC}"
  apt install -y ${PACKAGE} >/dev/null
done

echo -e "\nDone...\n"
