function prepend_path --description 'Prepend paths to PATH if it is unique'
    set -l new_path
    for p in $argv
        if not test -d $p
            if test -f $p
                echo '[prepend_path] A file path is specified:' $p >&2
            end
            continue
        end
        set -l rp (command realpath -s -- $p)
        if contains $rp $new_path; or contains $rp $PATH
            continue
        end
        set -p new_path $rp
    end
    set -gx PATH $new_path $PATH
end
