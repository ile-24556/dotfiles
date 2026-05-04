function update_everything
    sudo apt upgrade --update
    rustup update

    update_cargo_bins

    mise upgrade
    chezmoi update --init
end

function update_cargo_bins
    mise self-update
    cargo binstall --disable-strategies compile -- \
        (cargo install --list | rg '\.\d+:$' | cut -d ' ' -f 1 | rg -Fvx 'mise')
end
