# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmgll --wraps='chezmoi git -- log --date=iso-strict-local' --description 'alias cmgll=chezmoi git -- log --date=iso-strict-local'
    chezmoi git -- log --date=iso-strict-local $argv
end
