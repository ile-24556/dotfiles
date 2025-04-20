#!/bin/bash
set -eu

# Expects Ubuntu
if ! grep -q 'NAME="Ubuntu"' /etc/os-release ; then
  echo 'Unexpected environment'
  exit 1
fi

cd "$(dirname "${0}")"

link() {
  local to_be_linked="${1}"
  local link_name="${2:-${HOME}}/$(basename "${to_be_linked}")"

  rm -rf "${link_name}"
  ln -s "${to_be_linked}" "${link_name}"
}

for file in "$(pwd)"/files/.*; do
  link "${file}"
done

link "$(pwd)"/git "${HOME}/.config/"
