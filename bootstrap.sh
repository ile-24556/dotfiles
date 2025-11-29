#!/bin/bash

source "./scripts/mkdir-xdg.sh"

stow -v -t ~ -R -- home
