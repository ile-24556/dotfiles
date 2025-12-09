#!/bin/bash
#
# Copy files of a Zsh plugin into $XDG_DATA_HOME and zcompile them.
# Source this file and use the following function.

zcompile_plugin_files() {
  if [[ -n "${2}" ]]; then
    echo 'Too many arguments. Expect exactly one argument.'
    return 1
  fi

  local plugins_home="${XDG_DATA_HOME:?}/zsh/plugins"
  [[ -d "${plugins_home}" ]] || mkdir -p "${plugins_home}"

  local plugin_name="${1:?}"
  local orig_dir="/usr/share/${plugin_name}"

  cp -r "${orig_dir}" "${plugins_home}"

  local plugin_dir="${plugins_home}/${plugin_name}"

  for f in $(find "${plugin_dir}" -name '*.zsh'); do
    echo "Compiling ${f}"
    "$(which zsh)" -c "zcompile ${f}"
  done
}
