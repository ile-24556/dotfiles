function update_everything
    sudo apt upgrade --update
    rustup update
    cargo binstall --locked (cargo install --list | rg '\.\d+:' | cut -d ' ' -f 1)
    mise upgrade
end
