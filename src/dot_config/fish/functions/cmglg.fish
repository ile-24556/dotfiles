# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmglg --wraps='chezmoi git -- log --oneline --graph' --description 'alias cmglg=chezmoi git -- log --oneline --graph'
    chezmoi git -- log --oneline --graph $argv
end
