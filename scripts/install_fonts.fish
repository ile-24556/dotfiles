# Install my favourite fonts

function main
    prepare_clean_fonts_dir

    jetbrains_mono
    ibm_plex
    source_code_pro
    nerd_fonts
    others_from_google_fonts

    refresh_font_cache
end

function prepare_clean_fonts_dir
    if string match -q '*-WSL2' (uname -r)
        set -g FONTS_DIR /mnt/c/Users/Public/Downloads/favourite_fonts
    else
        set -g FONTS_DIR $XDG_DATA_HOME/fonts
    end
    rm -rf $FONTS_DIR
    mkdir -p $FONTS_DIR
end

function refresh_font_cache
    if string match -q '*-WSL2' (uname -r)
        return
    end
    fc-cache -rv
end

function jetbrains_mono
    cd (mktemp -d)

    gh release -R JetBrains/JetBrainsMono download -p 'JetBrainsMono-*.zip'
    unzip JetBrainsMono-*.zip 'fonts/variable/*'
    mv fonts $FONTS_DIR/jetbrains-mono
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

    download_font plex-sans-jp
    unzip ibm-plex-sans-jp.zip 'ibm-plex-sans-jp/fonts/complete/otf/unhinted/*'
    mv ibm-plex-sans-jp/fonts $FONTS_DIR/ibm-plex-sans-jp

    download_font plex-serif-variable
    unzip plex-serif-variable.zip 'plex-serif-variable/complete/ttf/*'
    mv plex-serif-variable $FONTS_DIR

    download_font plex-sans-variable
    unzip plex-sans-variable.zip 'fonts/complete/ttf/*'
    mv fonts $FONTS_DIR/plex-sans-variable

    download_font plex-sans-condensed
    unzip ibm-plex-sans-condensed.zip 'ibm-plex-sans-condensed/fonts/complete/otf/*'
    mv ibm-plex-sans-condensed/fonts $FONTS_DIR/ibm-plex-sans-condensed

    download_font plex-mono
    unzip ibm-plex-mono.zip 'ibm-plex-mono/fonts/complete/otf/*'
    mv ibm-plex-mono/fonts $FONTS_DIR/ibm-plex-mono
end

function source_code_pro
    gh release -R adobe-fonts/source-code-pro download -p 'VF-source-code-VF-*.zip'
    unzip VF-source-code-VF-*.zip 'VF/*.otf'
    mv VF $FONTS_DIR/source-code-pro
end

function nerd_fonts
    cd (mktemp -d)

    set -l dest $FONTS_DIR/nerd-fonts
    rm -rf $dest
    mkdir -p $dest

    gh release -R ryanoasis/nerd-fonts download -p JetBrainsMono.zip
    unzip JetBrainsMono.zip 'JetBrainsMonoNerdFont-*.ttf' -d $dest
end

function others_from_google_fonts
    set -l dest $FONTS_DIR/google-fonts
    rm -rf $dest
    mkdir -p $dest
    cd $dest

    set -l base_url https://raw.githubusercontent.com/google/fonts/main/

    curl -fsS $base_url'ofl/opensans/OpenSans%5Bwdth%2Cwght%5D.ttf' -o 'OpenSans[wdth,wght].ttf'
    curl -fsS $base_url'ofl/opensans/OpenSans-Italic%5Bwdth%2Cwght%5D.ttf' -o 'OpenSans-Italic[wdth,wght].ttf'
    curl -fsS $base_url'ofl/notoemoji/NotoEmoji%5Bwght%5D.ttf' -o 'NotoEmoji[wght].ttf'
    curl -fsS $base_url'ofl/notocoloremoji/NotoColorEmoji-Regular.ttf' -o 'NotoColorEmoji-Regular.ttf'
end

main
