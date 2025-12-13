#
# Common setups among POSIX-compliant shells.
#

# Set environment variables for XDG directories
source "${HOME}/.config/posix_shells/xdg-directories.sh"
source "${XDG_CONFIG_HOME}/posix_shells/xdg-based-variables.sh"

# snap
export PATH="/snap/bin:${PATH}"

# Volta
export PATH="$VOLTA_HOME/bin:$PATH"

# uv
source "$HOME/.local/bin/env"

# WSL-specific environment variables
if [[ "$(uname -r)" =~ -microsoft-standard-WSL2$ ]]; then
  # Allow GitHub CLI to start the default web browser on Windows from WSL shell
  export GH_BROWSER='/mnt/c/Windows/explorer.exe'

  # Signing Git commits with GnuPG
  export GPG_TTY="$(tty)"
fi

export BAT_THEME='Nord'

# rustup
source "${XDG_DATA_HOME}/cargo/env"

source "${XDG_CONFIG_HOME}/posix_shells/aliases.sh"
