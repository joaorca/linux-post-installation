# Things to do after installing Fedora Workstation 33

## Basic steps

### Install updates and reboot
```bash
sudo dnf upgrade --refresh
sudo dnf check
sudo dnf autoremove
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
sudo reboot now
```

## DNF flags
```bash
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
cat /etc/dnf/dnf.conf
# [main]
# gpgcheck=1
# installonly_limit=3
# clean_requirements_on_remove=True
# best=False
# skip_if_unavailable=True
# fastestmirror=1
# max_parallel_downloads=10
# deltarpm=true
```

## Set hostname
```bash
sudo hostnamectl set-hostname new-name
```

## Gnome Extensions and Tweaks
```bash
sudo dnf install -y gnome-tweaks gnome-shell-extension-appindicator
```

https://extensions.gnome.org/extension/906/sound-output-device-chooser/
https://extensions.gnome.org/extension/2890/tray-icons-reloaded/
https://extensions.gnome.org/extension/615/appindicator-support/


## packages
sudo dnf install zsh vim conky flameshot lm_sensors remmina
sudo dnf install yaru-icon-theme yaru-gtk3-theme numix-gtk-theme breeze-cursor-theme

## zsh
sudo usermod -s /usr/bin/zsh joaorca

## google chrome
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

## youtube-dl
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

## vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

## Insync
https://d2t3ff60b2tol4.cloudfront.net/builds/insync-3.3.4.40916-fc30.x86_64.rpm

## Rambox


