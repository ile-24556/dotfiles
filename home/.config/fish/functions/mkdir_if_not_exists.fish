function mkdir_if_not_exists
    argparse v/verbose -- $argv
    or return

    set absent (path filter -v $argv)
    set existed_files (path filter -f $argv)

    if set -q existed_files[1]
        if set -q existed_files[2]
            err The specified names are already used by files: $existed_files
        else
            err The specified name is already used by a file: $existed_files
        end
    end

    if set -q _flag_verbose
        set existed_dirs (path filter -d $argv)
        if set -q existed_dirs[1]
            if set -q existed_dirs[2]
                err Skipping already existed directories: $existed_dirs
            else
                err Skipping already existed directory: $existed_dirs
            end
        end

        if set -q absent[1]
            err mkdir -p $absent
        else
            err Nothing to mkdir
        end
    end

    if set -q absent[1]
        mkdir -p $absent
    end
end
