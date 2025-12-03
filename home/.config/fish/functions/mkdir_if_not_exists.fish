function mkdir_if_not_exists
    argparse v/verbose -- $argv
    or return

    set -l making (path filter -v $argv)

    if set -q _flag_verbose; or status is-interactive
        set -l ignoring (path filter $argv)
        if set -q ignoring[1]
            echo 'Skipping already existed name(s)': $ignoring
        end

        if set -q making[1]
            echo mkdir $making
        else
            echo Nothing to mkdir
        end
    end

    if set -q making[1]
        mkdir $making
    end
end
