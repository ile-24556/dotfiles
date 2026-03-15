function cmg --wraps='chezmoi git --' --description 'alias cmg=chezmoi git --'
    chezmoi git -- $argv
end
