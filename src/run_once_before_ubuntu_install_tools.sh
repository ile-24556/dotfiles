#!/bin/bash
#
# Install tools for Ubuntu

if ! grep -q 'ID=ubuntu' /usr/lib/os-release >/dev/null 2>&1; then
  echo 'You are not on Ubuntu; Exiting ...'
  exit
fi

echo 'Installing tools on Ubuntu.'

set -eu

sudo apt update && sudo apt upgrade -y

########################################
# fish shell
########################################

if ! command -v fish; then
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:fish-shell/release-4
  sudo apt update
  sudo apt install -y fish
fi

sudo apt install -y \
  git \
  tree \

if ! [[ "${SHELL}" == "$(command -v fish)" || "${GITHUB_ACTIONS}" == 'true' ]]; then
  chsh -s "$(command -v fish)"
fi

########################################
# GitHub CLI
########################################

if ! command -v gh; then
  echo 'Installing GitHub CLI ...'
  # https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian
  (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
fi

########################################
# Rust and tools written in Rust
########################################

# rustup
if ! command -v rustup; then
  echo 'Installing rustup ...'
  # https://rust-lang.org/tools/install/
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Rust binaries
if ! command -v cargo-binstall; then
  echo 'Installing cargo-binstall ...'
  # https://github.com/cargo-bins/cargo-binstall?tab=readme-ov-file#linux-and-macos
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash -s -- -y
fi

echo 'Installing cargo binaries'
cargo binstall --locked -y -- \
  bat \
  dprint \
  mise \
  oxipng \
  ripgrep \
  starship \
  uv \
  zellij \

########################################
# pre-commit
########################################

if ! command -v pre-commit; then
  uv tool install pre-commit
fi

cd "${HOME}/.local/share/chezmoi/"
pre-commit install
