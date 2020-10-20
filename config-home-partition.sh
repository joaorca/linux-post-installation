#!/usr/bin/env bash

YELLOW="\033[1;33m"; RED="\033[0;31m"; ENDCOLOR="\033[0m"

if [ $USER != root ]; then
  echo -e "\n${RED}Error: must be root! Exiting...${ENDCOLOR}"
  exit 0
fi

mkdir -p /mnt/home
mount /dev/sda1 /mnt/home
cp -aR /home/* /mnt/home
mv /home /home-old
#blkid /dev/sda1
echo "UUID=0dd27195-5dd0-48c3-a8c1-4b7f0a0ea8d8 /home ext4 defaults 0 2" >> /etc/fstab

