#!/bin/bash
#
# Install small set of tools and apply chezmoi on Ubuntu.

check_if_system_is_ubuntu() {
  if ! grep -q 'ID=ubuntu' /usr/lib/os-release >/dev/null 2>&1; then
    echo 'This script is supported only on Ubuntu.' >&2
    exit 1
  fi
}

set_tool_version_variables() {
  declare -rg MISE_VERSION='2026.2.24'
}

install_apt_packages() {
  sudo apt-get update -q

  if [[ "${GITHUB_ACTIONS:-}" != 'true' ]]; then
    sudo apt-get upgrade -qy
  fi

  sudo apt-get install -qy \
    curl \
    git \
    tzdata \
    wget \

}

install_fish() {
  readonly version_pattern=' 4\.[0-9]+\.[0-9]+$'
  if command -v fish && [[ "$(command fish --version)" =~ ${version_pattern} ]]; then
    return
  fi

  if ! command -v add-apt-repository; then
    sudo apt-get install -qy software-properties-common
  fi

  sudo add-apt-repository -y --ppa ppa:fish-shell/release-4
  sudo apt-get update -q
  sudo apt-get install -qy fish
}

change_login_shell() {
  sudo chsh -s "$(command -v fish)" "${USER}"
}

install_gh() {
  if command -v gh; then
    return
  fi

  # https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian
  # shellcheck disable=SC2024
  (type -p wget >/dev/null || (sudo apt-get update -q && sudo apt-get install wget -qy)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O"${out}" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && sudo tee < "${out}" /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt-get update -q \
    && sudo apt-get install gh -qy
}

add_paths() {
  export PATH="$HOME/.local/share/mise/shims:${HOME}/.cargo/bin:${HOME}/.local/bin:${PATH}"
}

install_rust_and_tools() {
  if ! command -v rustup; then
    # https://rust-lang.org/tools/install/
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    sudo apt-get install build-essential -qy
  fi

  if ! command -v cargo-binstall; then
    # https://github.com/cargo-bins/cargo-binstall?tab=readme-ov-file#linux-and-macos
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash -s -- -y
  fi

  cargo binstall --disable-strategies compile -y -- \
    bat \
    dprint \
    mise@"${MISE_VERSION}" \
    ripgrep \
    starship \
    uv \

}

chezmoi_init_and_apply() {
  mise use -g chezmoi@2
  if [[ "${GITHUB_ACTIONS:-}" == 'true' ]]; then
    chezmoi init --apply --source-path .
  else
    chezmoi init --apply 'ile-24556'
  fi
}

start_developping_dotfiles() {
  mise install

  if ! command -v pre-commit; then
    uv tool install pre-commit
  fi
  cd "${HOME}/.local/share/chezmoi/"
  pre-commit install
}

main() {
  set -eux
  check_if_system_is_ubuntu
  set_tool_version_variables
  install_apt_packages
  install_fish
  change_login_shell
  install_gh
  add_paths
  install_rust_and_tools
  chezmoi_init_and_apply
  start_developping_dotfiles
}

main
