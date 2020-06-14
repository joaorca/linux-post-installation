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
echo "UUID=255f02e8-64a6-455d-8e6f-b7348256ecb8 /home ext4 defaults 0 2" >> /etc/fstab

