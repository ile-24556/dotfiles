function bhh --description "print specified command's help command message with bat"
    $argv[1] help $argv[2..] | bat --plain --language=help
end
