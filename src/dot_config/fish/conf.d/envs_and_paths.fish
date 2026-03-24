# App-specific environment variables and paths

status is-login; or return 0

# Define WSL-specific environment variables
if string match -q '*-WSL2' (uname -r)
    # Allow GitHub CLI to start the default web browser on Windows from WSL shell
    set -gx GH_BROWSER /mnt/c/Windows/explorer.exe
end

# Arugument order matters; It is like LIFO: uv, rustup, mise
prepend_path \
    (if command -v go >/dev/null; go env GOBIN; end) \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.local/share/mise/shims
