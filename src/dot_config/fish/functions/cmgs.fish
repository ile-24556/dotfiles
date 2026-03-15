# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmgs --wraps='chezmoi git -- status --short' --description 'alias cmgs=chezmoi git -- status --short'
    chezmoi git -- status --short $argv
end
