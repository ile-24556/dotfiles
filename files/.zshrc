if [[ -f ~/.aliases.sh ]]; then
  . ~/.aliases.sh
fi

. "$HOME/.cargo/env"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.local/bin/env"

eval "$(starship init zsh)"

if [[ "$(uname -r)" =~ -microsoft-standard-WSL2$ ]]; then
  export GH_BROWSER='/mnt/c/Windows/explorer.exe'
fi
