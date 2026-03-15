# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmglf --wraps='chezmoi git -- log --format=fuller --date=iso-strict-local' --description 'alias cmglf=chezmoi git -- log --format=fuller --date=iso-strict-local'
    chezmoi git -- log --format=fuller --date=iso-strict-local $argv
end
