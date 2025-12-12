# XDG Base Directory Specification's environment variables and base directories
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
mkdir_if_not_exists $XDG_DATA_HOME $XDG_CONFIG_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

# App-specific environment variables
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx GOPATH $XDG_DATA_HOME/go
set -gx PYTHON_HISTORY $XDG_STATE_HOME/python/history
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
