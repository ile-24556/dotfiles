function bm --description "Print specified command's man page with bat"
    man $argv | bat --plain --language=man
end
