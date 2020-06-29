#!/usr/bin/env bash

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
  echo "mkdir -p $fonts_dir"
  mkdir -p "${fonts_dir}"
else
  echo "Found fonts dir $fonts_dir"
fi

for type in Bold Light Medium Regular Retina; do
  file_path="${fonts_dir}/FiraCode-${type}.ttf"
  file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
  if [ ! -e "${file_path}" ]; then
    wget -q "${file_url}" -O "${file_path}" --show-progress
  else
    echo "Found existing file $file_path"
  fi;
done

echo "fc-cache -f"
fc-cache -f
