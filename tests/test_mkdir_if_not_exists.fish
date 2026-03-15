set -l tmpd (mktemp -d)
mkdir -p $tmpd/dir1 $tmpd/dir2
touch $tmpd/file1 $tmpd/file2

cat src/dot_config/fish/functions/*.fish | source

mkdir_if_not_exists $tmpd/dir3
if not test -d $tmpd/dir3
    err Test failed on mkdir
    rm -rf $tmpd
    return 1
end

set out (mkdir_if_not_exists $tmpd/dir1 2>&1 | string collect)
if string length -q $out
    err Test failed on directory collision message verbosity
    rm -rf $tmpd
    return 2
end

set expected (begin; err Skipping already existed directory: $tmpd/dir1 2>&1; err Nothing to mkdir 2>&1; end | string collect)
set out (mkdir_if_not_exists -v $tmpd/dir1 2>&1 | string collect)
if test $out != $expected
    err Test failed on directory name collision message content\nExpected: `$expected`\nActual: `$out`
    rm -rf $tmpd
    return 3
end

set expected (begin; err Skipping already existed directories: $tmpd/dir1 $tmpd/dir2 2>&1; err Nothing to mkdir 2>&1; end | string collect)
set out (mkdir_if_not_exists -v $tmpd/dir1 $tmpd/dir2 2>&1 | string collect)
if test $out != $expected
    err Test failed on directory names collision message content\nExpected: `$expected`\nActual: `$out`
    rm -rf $tmpd
    return 4
end

set expected (err The specified name is already used by a file: $tmpd/file1 2>&1 | string collect)
set out (mkdir_if_not_exists $tmpd/file1 2>&1 | string collect)
if test $out != $expected
    err Test failed on file name collision message content with a file\nExpected: `$expected`\nActual: `$out`
    rm -rf $tmpd
    return 5
end

set expected (err The specified names are already used by files: $tmpd/file1 $tmpd/file2 2>&1 | string collect)
set out (mkdir_if_not_exists $tmpd/file1 $tmpd/file2 2>&1 | string collect)
if test $out != $expected
    err Test failed on file names collision message content with two files\nExpected: `$expected`\nActual: `$out`
    rm -rf $tmpd
    return 6
end

rm -rf $tmpd
