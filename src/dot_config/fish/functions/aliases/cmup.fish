function cmup --wraps='chezmoi update' --description 'alias cmup=chezmoi update'
    chezmoi update $argv
end
