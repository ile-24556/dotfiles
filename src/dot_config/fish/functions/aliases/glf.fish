function glf --wraps='git log --format=fuller --date=iso-strict-local' --description 'alias glf=git log --format=fuller --date=iso-strict-local'
    git log --format=fuller --date=iso-strict-local $argv
end
