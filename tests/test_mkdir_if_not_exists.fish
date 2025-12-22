rm -rf tmp
mkdir -p tmp/dir1 tmp/dir2
touch tmp/file1 tmp/file2

source home/.config/fish/functions/mkdir_if_not_exists.fish

mkdir_if_not_exists tmp/dir3
if not test -d tmp/dir3
    err Test failed on mkdir
    rm -rf tmp
    return 1
end

set out (mkdir_if_not_exists tmp/dir1 2>&1 | string collect)
if string length -q $out
    err Test failed on directory collision message verbosity
    rm -rf tmp
    return 2
end

set expected (begin; err Skipping already existed directory: tmp/dir1 2>&1; err Nothing to mkdir 2>&1; end | string collect)
set out (mkdir_if_not_exists -v tmp/dir1 2>&1 | string collect)
if test $out != $expected
    err Test failed on directory name collision message content\nExpected: `$expected`\nActual: `$out`
    rm -rf tmp
    return 3
end

set expected (begin; err Skipping already existed directories: tmp/dir1 tmp/dir2 2>&1; err Nothing to mkdir 2>&1; end | string collect)
set out (mkdir_if_not_exists -v tmp/dir1 tmp/dir2 2>&1 | string collect)
if test $out != $expected
    err Test failed on directory names collision message content\nExpected: `$expected`\nActual: `$out`
    rm -rf tmp
    return 4
end

set expected (err The specified name is already used by a file: tmp/file1 2>&1 | string collect)
set out (mkdir_if_not_exists tmp/file1 2>&1 | string collect)
if test $out != $expected
    err Test failed on file name collision message content with a file\nExpected: `$expected`\nActual: `$out`
    rm -rf tmp
    return 5
end

set expected (err The specified names are already used by files: tmp/file1 tmp/file2 2>&1 | string collect)
set out (mkdir_if_not_exists tmp/file1 tmp/file2 2>&1 | string collect)
if test $out != $expected
    err Test failed on file names collision message content with two files\nExpected: `$expected`\nActual: `$out`
    rm -rf tmp
    return 6
end

rm -rf tmp
