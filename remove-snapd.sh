#!/usr/bin/env bash

YELLOW="\033[1;33m"; RED="\033[0;31m"; ENDCOLOR="\033[0m"

if [ $USER != root ]; then
  echo -e "\n${RED}Error: must be root! Exiting...${ENDCOLOR}"
  exit 0
fi

#snap remove $(snap list |grep -vE 'Name' | awk '{print $1}') || true
#umount -lf /snap/core/* || true

SNAP_FOLDERS=(
  "/snap"
  "/var/snap"
  "/var/cache/snapd"
  "/var/lib/snapd"
  "/usr/lib/snapd"
  "/home/*/snap"
)

for SNAP_FOLDER in ${SNAP_FOLDERS[@]}; do
  if [ -d ${SNAP_FOLDER} ]; then
    du ${SNAP_FOLDER} -h -d 0
    rm -rf ${SNAP_FOLDER} &> /dev/null
  fi
done

apt remove gnome-software-plugin-snap -y
apt autoremove --purge snapd -y
