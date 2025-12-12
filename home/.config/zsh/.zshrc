setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Set environment variables for XDG directories
source "${HOME}/.config/zsh/xdg-directories.sh"
source "${XDG_CONFIG_HOME}/zsh/xdg-based-variables.sh"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
test -d "${XDG_STATE_HOME}/zsh" || mkdir -p "${XDG_STATE_HOME}/zsh"

# Use modern completion system
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
# ~/.zcompdump
test -d "${XDG_CACHE_HOME}/zsh" || mkdir -p "${XDG_CACHE_HOME}/zsh"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'



export PATH="/snap/bin:${PATH}"

# Originally '/usr/share'
readonly ZSH_PLUGIN_DATA_HOME="${XDG_DATA_HOME}/zsh/plugins"

if ! [[ -f "${ZSH_PLUGIN_DATA_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh.zwc" ]]; then
  echo 'Compiling zsh-autosuggestions files'
  source "${XDG_CONFIG_HOME}/zsh/zcompile-plugin.sh"
  zcompile_plugin_files 'zsh-autosuggestions'
fi
source "${ZSH_PLUGIN_DATA_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"

if ! [[ -f "${ZSH_PLUGIN_DATA_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh.zwc" ]]; then
  echo 'Compiling zsh-syntax-highlighting files'
  source "${XDG_CONFIG_HOME}/zsh/zcompile-plugin.sh"
  zcompile_plugin_files 'zsh-syntax-highlighting'
fi
source "${ZSH_PLUGIN_DATA_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

. "${XDG_CONFIG_HOME}/zsh/aliases.sh"

export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.local/bin/env"

eval "$(starship init zsh)"

if [[ "$(uname -r)" =~ -microsoft-standard-WSL2$ ]]; then
  export GH_BROWSER='/mnt/c/Windows/explorer.exe'
fi

export BAT_THEME='Nord'

# rustup
. "${XDG_DATA_HOME}/cargo/env"
