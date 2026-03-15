# Generated from a Git alias by prepare_alias
# Defined via `source`
function cmglsf --wraps='chezmoi git -- ls-files' --description 'alias cmglsf=chezmoi git -- ls-files'
    chezmoi git -- ls-files $argv
end
