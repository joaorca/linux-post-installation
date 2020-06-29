#!/usr/bin/env bash

# Adapted from 71529-ubucleaner.sh - http://www.opendesktop.org/CONTENT/content-files/71529-ubucleaner.sh

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"; RED="\033[0;31m"; ENDCOLOR="\033[0m"

if [ $USER != root ]; then
  echo -e "\n${RED}Error: must be root! Exiting...${ENDCOLOR}"
  exit 0
fi

echo -e "\n${YELLOW}Cleaning apt ...${ENDCOLOR}"
apt clean
apt autoremove -y --purge
apt autoclean

echo -e "\n${YELLOW}Cleaning old revisions of snaps ...${ENDCOLOR}"
snap list --all | awk '/disabled/{print $1, $3}' |
while read snapname revision; do
  snap remove "${snapname}" --revision="${revision}"
done

echo -e "\n${YELLOW}Cleaning snap cache ...${ENDCOLOR}"
rm -f /var/lib/snapd/cache/*

echo -e "\n${YELLOW}Those packages were uninstalled without --purge:${ENDCOLOR}"
for PKGNAME in $OLDCONF ; do  # a better way to handle errors
  echo -e "${YELLOW}Purge package ${PKGNAME}${ENDCOLOR}"
  apt-cache show "$PKGNAME"|grep Description: -A3
  apt-get -y purge "$PKGNAME"
done

echo -e "\n${YELLOW}Removing old kernels...${ENDCOLOR}"
echo current kernel you are using:
uname -a
echo -e "----> ${OLDKERNELS}"
apt remove -y $OLDKERNELS --purge

echo -e "\n${YELLOW}Emptying every trashes...${ENDCOLOR}"
rm -rf /home/*/.cache/thumbnails/*/** &> /dev/null
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e "\n${YELLOW}Cleaning Journal ...${ENDCOLOR}"
journalctl --vacuum-time=1s

echo -e "\n${YELLOW}Script Finished!${ENDCOLOR}"
