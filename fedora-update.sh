#!/usr/bin/env bash

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

user="$(id -un 2>/dev/null || true)"
sh_c='sh -c'
if [ "$user" != 'root' ]; then
  if command_exists sudo; then
	  sh_c='sudo -E sh -c'
	elif command_exists su; then
		sh_c='su -c'
	else
		cat >&2 <<-'EOF'
		Error: this installer needs the ability to run commands as root.
		We are unable to find either "sudo" or "su" available to make this happen.
		EOF
		exit 1
	fi
fi

set -x
$sh_c "dnf upgrade --refresh"
$sh_c "dnf check"
$sh_c "dnf autoremove"
