# Export environment variables for each app
# to comform to XDG Base Directory Specification.

# ~/.cargo
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# ~/.dotnet
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# ~/go
export GOPATH="${XDG_DATA_HOME}/go"

# GnuPG
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# ~/.lesshst
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"
test -f "${HOME}/.lesshst" && mv "${HOME}/.lesshst" "${LESSHISTFILE}"

# ~/.npm
export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"

# ~/.python_history
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"

# ~/.rustup
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# ~/.volta
export VOLTA_HOME="${XDG_DATA_HOME}/volta"

# ~/.w3m
export W3M_DIR="${XDG_DATA_HOME}/w3m"

# ~/.wget-hsts
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
