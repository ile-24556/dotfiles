function glg --wraps='git log --oneline --graph' --description 'alias glg=git log --oneline --graph'
    git log --oneline --graph $argv
end
