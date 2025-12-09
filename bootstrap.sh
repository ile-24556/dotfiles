#!/bin/bash

if ! [[ "$(uname -r)" =~ -microsoft-standard-WSL2$ ]]; then
  echo "Unexpected system: $(uname -r)" >&2
  return 1
fi

stow -v -t ~ -R -- home
