#!/bin/bash
set -eu

stow --dir="$(dirname "${0}")" --target="${HOME}" --verbose --restow --dotfiles files
