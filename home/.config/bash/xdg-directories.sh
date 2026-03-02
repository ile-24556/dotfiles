# Export environment variable for XDG Base Directory Specification.
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

# Make XDG base directories if not exist
test -d "${XDG_DATA_HOME}"   || mkdir -p "${XDG_DATA_HOME}"
test -d "${XDG_CONFIG_HOME}" || mkdir -p "${XDG_CONFIG_HOME}"
test -d "${XDG_STATE_HOME}"  || mkdir -p "${XDG_STATE_HOME}"
test -d "${XDG_CACHE_HOME}"  || mkdir -p "${XDG_CACHE_HOME}"
