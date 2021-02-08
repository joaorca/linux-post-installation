#!/usr/bin/env bash

TITLE_COLOR='\033[1;31m'
NC='\033[0m'

echo -e "\n${TITLE_COLOR}Atualizando repositórios${NC}"
sudo apt-get update -qq >/dev/null

echo -e "\n${TITLE_COLOR}Instalando pacotes${NC}"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq git curl >/dev/null
sudo apt-get install -y -qq --no-install-recommends zsh >/dev/null