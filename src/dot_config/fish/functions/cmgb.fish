# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmgb --wraps='chezmoi git -- branch -v' --description 'alias cmgb=chezmoi git -- branch -v'
    chezmoi git -- branch -v $argv
end
