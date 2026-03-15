function gb --wraps='git branch -v' --description 'alias gb=git branch -v'
    git branch -v $argv
end
