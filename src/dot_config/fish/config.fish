if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status is-login
    # Sign Git commits with GnuPG
    set -gx GPG_TTY (tty)
end
