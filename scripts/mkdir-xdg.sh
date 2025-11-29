#!/bin/bash
#
# Make directories for each app to comform to XDG Base Directory Specification.

source "./home/.config/zsh/export-xdg-directories.sh"
source "./home/.config/zsh/export-xdg-based-variables.sh"

# XDG Base Directory Specification
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_STATE_HOME}"
mkdir -p "${XDG_CACHE_HOME}"

# ~/.bash_history
mkdir -p "${XDG_STATE_HOME}/bash"
touch "${HISTFILE}"

# ~/.lesshst
if [[ -f ~/.lesshst ]]; then
  mv ~/.lesshst "${LESSHISTFILE}"
fi

# ~/.zcompdump
mkdir -p "${XDG_CACHE_HOME}/zsh"

# ~/.zsh_history
mkdir -p "${XDG_STATE_HOME}/zsh"
