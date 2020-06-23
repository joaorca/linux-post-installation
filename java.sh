#!/usr/bin/env bash

ERROR_COLOR='\033[7;31m'
TITLE_COLOR='\033[1;31m'
NC='\033[0m'

JAVA_LINK="https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jre-8u251-linux-x64.tar.gz?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jre-8u251-linux-x64.tar.gz&BHost=javadl.sun.com&File=jre-8u251-linux-x64.tar.gz&AuthParam=1591755719_ca4579491e357f90b2eb3c0ccfbdf4ea&ext=.gz"

if [ $(id -u) != 0 ]; then
  echo -e "${ERROR_COLOR}O script deve ser executado como root${NC}"
  exit
fi

echo -e "\n${TITLE_COLOR}Instalando JAVA${NC}"
wget -q ${JAVA_LINK} --show-progress -O /tmp/java.tar.gz
tar -zxf /tmp/java.tar.gz -C /tmp/
mkdir -p /opt/java-jre
mv /tmp/jre*/* /opt/java-jre
update-alternatives --install /usr/bin/java java /opt/java-jre/bin/java 1
