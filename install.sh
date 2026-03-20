#!/bin/bash
#
# Install small set of tools.

check_if_system_is_ubuntu() {
  if ! grep -q 'ID=ubuntu' /usr/lib/os-release >/dev/null 2>&1; then
    echo 'You are not in Ubuntu; Abort.' >&2
    exit 1
  fi
}

install_apt_packages() {
  sudo apt-get update -q

  if [[ "${GITHUB_ACTIONS:-}" != 'true' ]]; then
    sudo apt-get upgrade -qy
  fi

  sudo apt-get install -qy \
    curl \
    git \
    tree \
    wget \

}

install_fish() {
  if ! command -v fish; then
    if [[ "${GITHUB_ACTIONS:-}" == 'true' ]]; then
      sudo DEBIAN_FRONTEND=noninteractive apt install tzdata
    fi

    sudo apt-get install -qy software-properties-common
    sudo add-apt-repository -y --ppa ppa:fish-shell/release-4
    sudo apt-get update
    sudo apt-get install -qy fish
  fi

  sudo chsh -s "$(command -v fish)" "${USER}"
}

install_gh() {
  if ! command -v gh; then
    # https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian
    # shellcheck disable=SC2002
    (type -p wget >/dev/null || (sudo apt-get update -q && sudo apt-get install wget -qy)) \
      && sudo mkdir -p -m 755 /etc/apt/keyrings \
      && out=$(mktemp) && wget -nv -O"${out}" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      && cat "${out}" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
      && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
      && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
      && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
      && sudo apt-get update -q \
      && sudo apt-get install gh -qy
  fi
}

add_paths() {
  export PATH="${HOME}/.local/share/mise/shims:${HOME}/.cargo/bin:${HOME}/.local/bin:${PATH}"
}

install_from_rust_to_chezmoi() {
  if ! command -v rustup; then
    # https://rust-lang.org/tools/install/
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    sudo apt-get install build-essential -qy
  fi

  if ! command -v cargo-binstall; then
    # https://github.com/cargo-bins/cargo-binstall?tab=readme-ov-file#linux-and-macos
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash -s -- -y
  fi

  cargo binstall --locked -y -- \
    bat \
    deno \
    dprint \
    fd \
    mise \
    ripgrep \
    starship \
    uv \

  mise use chezmoi@2
}

chezmoi_init_and_apply() {
  if [[ "${GITHUB_ACTIONS:-}" == 'true' ]]; then
    chezmoi init --source ./src
  else
    chezmoi init 'ile-24556'
  fi
  chezmoi apply
}

main() {
  set -eux
  check_if_system_is_ubuntu
  install_apt_packages
  install_fish
  install_gh
  add_paths
  install_from_rust_to_chezmoi
  chezmoi_init_and_apply
}

main
