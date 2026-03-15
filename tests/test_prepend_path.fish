cat src/dot_config/fish/functions/non_aliases/*.fish | source

set -l ret 0

rm -rf tmp
mkdir -p tmp/d{1,2,3}
touch tmp/f

set -l tmp_path $PATH
set PATH (builtin realpath tmp/d2)

prepend_path \
    tmp/d1 \
    tmp/../tmp/d1 \
    tmp/d2 \
    tmp/d3 \
    tmp/n \
    tmp/f

set -l expected (builtin realpath tmp/d3):(builtin realpath tmp/d1):(builtin realpath tmp/d2)

if test "$PATH" != "$expected"
    echo Test failed:\nActual: "$PATH"\nExpected: "$expected" >&2
    set ret 1
end

set -gx PATH $tmp_path

rm -rf tmp
return $ret
