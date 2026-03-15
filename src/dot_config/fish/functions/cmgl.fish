# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmgl --wraps='chezmoi git -- log --oneline' --description 'alias cmgl=chezmoi git -- log --oneline'
    chezmoi git -- log --oneline $argv
end
