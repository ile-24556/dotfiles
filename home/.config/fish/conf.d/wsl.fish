# Define WSL-specific environment variables
if string match -q '*-WSL2' (uname -r)
  # Allow GitHub CLI to start the default web browser on Windows from WSL shell
  set -gx GH_BROWSER /mnt/c/Windows/explorer.exe

  # Signing Git commits with GnuPG
  set -gx GPG_TTY (tty)
end
