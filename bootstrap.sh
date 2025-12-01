#!/bin/bash

if ! [[ "$(uname -r)" =~ -microsoft-standard-WSL2$ ]]; then
  echo "Unexpected system: $(uname -r)" >&2
  return 1
fi

source "./scripts/mkdir-xdg.sh"

source './scripts/zcompile-plugin.sh'
zcompile_plugin_files 'zsh-autosuggestions'
zcompile_plugin_files 'zsh-syntax-highlighting'

stow -v -t ~ -R -- home
