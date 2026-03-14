function bh --description "print specified command's --help message with bat"
    $argv --help | bat --plain --language=help
end
