#!/usr/bin/env bash

APPS=(
  "WebStorm"
  "PhpStorm"
  "datagrip"
)

for APP in ${APPS[@]}
do
  sed -i 's/# idea.config/idea.config/g' /opt/jetbrains-toolbox/apps/${APP}/ch-0/*/bin/idea.properties
  sed -i 's/# idea.system/idea.system/g' /opt/jetbrains-toolbox/apps/${APP}/ch-0/*/bin/idea.properties
done