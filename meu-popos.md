# Things to do after installing Pop!_OS

## Install updates and reboot
```bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt autoclean
sudo fwupdmgr get-devices
sudo fwupdmgr get-updates
sudo fwupdmgr update
sudo reboot now
```

## Set Hybrid Graphics
```bash
sudo system76-power graphics hybrid
sudo reboot now
```

## Set hostname
```bash
sudo hostnamectl set-hostname new-name
```

## OpenVPN
```bash
sudo apt install -y openvpn network-manager-openvpn network-manager-openvpn-gnome
```

## Multimedia Codecs
```bash
sudo apt install -y libavcodec-extra libdvd-pkg; sudo dpkg-reconfigure libdvd-pkg
```

## packages
```bash
sudo apt install -y vim code conky lm-sensors flameshot gnome-tweaks google-chrome-stable discord
sudo apt install -y yaru-theme-icon yaru-theme-gtk numix-gtk-theme breeze-cursor-theme
```

## zsh
```bash
sudo apt install -y zsh
sudo usermod -s /usr/bin/zsh joaorca
```

## youtube-dl
```bash
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl; sudo chmod a+rx /usr/local/bin/youtube-dl
```

## Insync

## Rambox

## Insomnia

## GitKraken

## Docker

## Java

## Node

## JetBrains