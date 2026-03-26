function update_everything
    sudo apt upgrade --update
    rustup update

    update_cargo_bins

    mise upgrade
    chezmoi update
end

function update_cargo_bins
    set -l bins (cargo install --list | rg '\.\d+:' | cut -d ' ' -f 1)
    set -l bins_to_reserve deno mise
    set -l bins_to_update
    for bin in $bins
        if contains $bin $bins_to_reserve
            continue
        end
        set -a bins_to_update $bin
    end
    cargo binstall --disable-strategies compile -- $bins_to_update
    deno upgrade
    mise self-update
end
