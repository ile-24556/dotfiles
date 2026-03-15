# Define WSL-specific environment variables

status is-login; or return 0

string match -q '*-WSL2' (uname -r); or return 0

# Allow GitHub CLI to start the default web browser on Windows from WSL shell
set -gx GH_BROWSER /mnt/c/Windows/explorer.exe

# Conditional call for some commands
function bat --description 'Choose bat.exe if called on Windows'
    if string match -q '/mnt/c/*' $PWD
        bat.exe $argv
        return
    end
    command bat $argv
end
function git --description 'Choose git.exe if called on Windows'
    if string match -q '/mnt/c/*' $PWD
        command git.exe $argv
        return
    end
    command git $argv
end
function rg --description 'Choose rg.exe if called on Windows'
    if string match -q '/mnt/c/*' $PWD
        rg.exe $argv
        return
    end
    command rg $argv
end
