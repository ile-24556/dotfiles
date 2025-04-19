#!/bin/bash
set -eu

cd "$(dirname "${0}")"
readonly project_root="$(pwd)"

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
