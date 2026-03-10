#!/bin/bash

set -eu

if [[ "$(uname --operating-system)" != "GNU/Linux" ]]; then
  echo "Unexpected system: $(uname --all)" >&2
  return 1
fi

stow -v -t ~ -R -- home
