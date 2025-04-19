if [[ -f ~/.aliases.sh ]]; then
  . ~/.aliases.sh
fi

. "$HOME/.cargo/env"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.local/bin/env"

eval "$(starship init zsh)"
