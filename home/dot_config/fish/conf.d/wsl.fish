# Define WSL-specific environment variables

status is-login; or return 0

string match -q '*-WSL2' (uname -r); or return 0

# Allow GitHub CLI to start the default web browser on Windows from WSL shell
set -gx GH_BROWSER /mnt/c/Windows/explorer.exe
