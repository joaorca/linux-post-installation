#!/usr/bin/env bash

EXTENSION_DIR=~/.local/share/gnome-shell/extensions

rm -rf ${EXTENSION_DIR}/gTile@vibou
git clone https://github.com/gTile/gTile.git \
  ${EXTENSION_DIR}/gTile@vibou
gnome-extensions enable gTile@vibou

rm -rf ${EXTENSION_DIR}/sound-output-device-chooser@kgshank.net
git clone https://github.com/kgshank/gse-sound-output-device-chooser.git \
  ${EXTENSION_DIR}/sound-output-device-chooser
cp --recursive ${EXTENSION_DIR}/sound-output-device-chooser/sound-output-device-chooser@kgshank.net \
  ${EXTENSION_DIR}/sound-output-device-chooser@kgshank.net
rm -rf ${EXTENSION_DIR}/sound-output-device-chooser
gnome-extensions enable sound-output-device-chooser@kgshank.net

gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'

gsettings set org.gnome.desktop.interface cursor-theme 'breeze_cursors'