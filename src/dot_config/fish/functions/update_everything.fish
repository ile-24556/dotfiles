function update_everything
    sudo apt upgrade --update
    rustup update

    update_cargo_bins

    mise upgrade
    chezmoi update
end

function update_cargo_bins
    set -l bins (cargo install --list | rg '\.\d+:' | rg -Fv -e deno -e mise | cut -d ' ' -f 1)
    cargo binstall --disable-strategies compile -- $bins
    deno upgrade
    mise self-update
end
