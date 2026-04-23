function update_everything
    sudo apt upgrade --update
    rustup update

    update_cargo_bins

    mise upgrade
    chezmoi update --init
end

function update_cargo_bins
    set -l bins (cargo install --list | rg '\.\d+:$' | rg -Fv mise | cut -d ' ' -f 1)
    cargo binstall --disable-strategies compile -- $bins
    mise self-update
end
