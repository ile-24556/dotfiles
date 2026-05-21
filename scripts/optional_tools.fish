# Install tools ommited from 'install.sh'.

if not rg -F 'ID=ubuntu' /usr/lib/os-release >/dev/null 2>&1
    echo This script is supported only on Ubuntu. >&2
    return 1
end

sudo apt install -- golang shellcheck tree

cargo binstall --disable-strategies compile -- \
    deno \
    du-dust \
    eza \
    fd-find \
    hyperfine \
    mise \
    oxipng \
    yazi-fm \
    zoxide

mise install

update_everything
