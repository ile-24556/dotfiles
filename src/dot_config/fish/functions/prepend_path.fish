function prepend_path --description 'Prepend paths to PATH if it is unique'
    set -l new_path
    for p in $argv
        set -l rp (builtin realpath -s -- $p)
        if contains $rp $new_path; or contains $rp $PATH; or not test -d $rp
            continue
        end
        set -p new_path $rp
    end
    set -gx PATH $new_path $PATH
end
