# XDG Base Directory Specification's environment variables and base directories

status is-login; or return 0

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
mkdir_if_not_exists $XDG_DATA_HOME $XDG_CONFIG_HOME $XDG_STATE_HOME $XDG_CACHE_HOME
