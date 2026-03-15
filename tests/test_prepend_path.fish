cat src/dot_config/fish/functions/*.fish | source

set -l ret 0

set -l tmpd (mktemp -d)
mkdir -p $tmpd/d{1,2,3}
touch $tmpd/f

return

set -l tmp_path $PATH
set PATH (builtin realpath $tmpd/d2)

prepend_path \
    $tmpd/d1 \
    $tmpd/d1/../d1 \
    $tmpd/d2 \
    $tmpd/d3 \
    $tmpd/n \
    $tmpd/f

set -l expected (builtin realpath $tmpd/d3):(builtin realpath $tmpd/d1):(builtin realpath $tmpd/d2)

if test "$PATH" != "$expected"
    echo Test failed:\nActual: "$PATH"\nExpected: "$expected" >&2
    set ret 1
end

set -gx PATH $tmp_path

rm -rf $tmpd
return $ret
