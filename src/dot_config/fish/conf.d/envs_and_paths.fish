# App-specific environment variables and paths

# Define WSL-specific environment variables
if string match -q '*-WSL2' (uname -r)
    # Allow GitHub CLI to start the default web browser on Windows from WSL shell
    set -gx GH_BROWSER /mnt/c/Windows/explorer.exe
end

# Arugument order matters; It is like LIFO: uv, rustup, mise
prepend_path \
    $HOME/go/bin \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.local/share/mise/shims

set -gx PYTHONUTF8 1
set -gx PYTHONWARNDEFAULTENCODING true
