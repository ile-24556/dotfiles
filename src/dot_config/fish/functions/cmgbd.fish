# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmgbd --wraps='chezmoi git -- branch -d' --description 'alias cmgbd=chezmoi git -- branch -d'
    chezmoi git -- branch -d $argv
end
