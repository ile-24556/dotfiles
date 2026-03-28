function make_destination
    set -gx fonts_dir $XDG_DATA_HOME/fonts
    mkdir -p $fonts_dir
end

function jetbrains_mono
    cd (mktemp -d)

    set -l dest $fonts_dir/jetbrainsmono
    mkdir -p $dest

    gh release -R JetBrains/JetBrainsMono download -p 'JetBrainsMono-*.zip'
    unzip JetBrainsMono-*.zip 'fonts/variable/*' -d $dest
end

function ibm_plex
    cd (mktemp -d)

    gh release -R IBM/plex ls --json tagName --jq '.[].tagName' >tags.txt

    function download_font
        set -l font_name $argv[1]
        set -l tag (rg -Fm 1 -- $font_name tags.txt)
        echo font_name: $font_name, tag: $tag

        gh release download -R IBM/plex $tag -p '*'$font_name.zip
    end

    set -l dest $fonts_dir/IBM-Plex
    mkdir -p $dest

    # TODO: hinted or unhinted
    download_font plex-sans-jp
    unzip ibm-plex-sans-jp.zip 'ibm-plex-sans-jp/fonts/complete/otf/hinted/*' -d $dest

    download_font plex-serif-variable
    unzip plex-serif-variable.zip 'plex-serif-variable/complete/ttf/*' -d $dest

    download_font plex-sans-variable
    unzip plex-sans-variable.zip 'fonts/complete/ttf/*' -d $dest

    download_font plex-sans-condensed
    unzip ibm-plex-sans-condensed.zip 'ibm-plex-sans-condensed/fonts/complete/otf/*' -d $dest

    download_font plex-mono
    unzip ibm-plex-mono.zip 'ibm-plex-mono/fonts/complete/otf/*' -d $dest
end

function nerd_fonts
    cd (mktemp -d)

    set -l dest $fonts_dir/nerd_fonts
    mkdir -p $dest

    gh release -R ryanoasis/nerd-fonts download -p JetBrainsMono.zip
    unzip JetBrainsMono.zip 'JetBrainsMonoNerdFont-*.ttf' -d $dest
end

function others
    set -l dest $fonts_dir/others
    mkdir -p $dest
    cd $dest

    set -l base_url https://raw.githubusercontent.com/google/fonts/main/

    curl -fsSO $base_url'ofl/opensans/OpenSans%5Bwdth%2Cwght%5D.ttf'
    curl -fsSO $base_url'ofl/opensans/OpenSans-Italic%5Bwdth%2Cwght%5D.ttf'
    curl -fsSO $base_url'ofl/notoemoji/NotoEmoji%5Bwght%5D.ttf'
    curl -fsSO $base_url'ofl/notocoloremoji/NotoColorEmoji-Regular.ttf'
end

function main
    make_destination
    jetbrains_mono
    ibm_plex
    nerd_fonts
    others

    fc-cache
end

main
