#!/bin/bash
set -eu

cd "$(dirname "${0}")/files"
readonly files_dir="$(pwd)"

link() {
  local file="${1}"
  local target_dir="${2:-${HOME}}"

  rm -f "${target_dir}/${file}"
  ln -s "${files_dir}/${file}" "${target_dir}/${file}"
}

for file in .*; do
  link "${file}"
done
