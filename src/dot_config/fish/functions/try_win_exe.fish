function try_win_exe --description 'Use the Windows binary in a Windows directory if possible'
    string match -qr '^/mnt/[c-f]/' $PWD
    and command $argv[1].exe $argv[2..]
    or command $argv[1] $argv[2..]
end
