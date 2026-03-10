if status is-interactive
    # Commands to run in interactive sessions can go here
end

mise activate fish | source

# Sign Git commits with GnuPG
set -gx GPG_TTY (tty)
