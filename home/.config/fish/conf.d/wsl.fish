# Define WSL-specific environment variables
string match -q '*-WSL2' (uname -r)
or return 0

# Allow GitHub CLI to start the default web browser on Windows from WSL shell
set -gx GH_BROWSER /mnt/c/Windows/explorer.exe

# Sign Git commits with GnuPG
set -gx GPG_TTY (tty)
