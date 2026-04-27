if not command -v gsettings >/dev/null
    return
end
if not gsettings list-schemas | grep -Fq 'org.gnome.desktop.interface'
    return
end

gsettings set org.gnome.desktop.interface font-name 'ui-sans-serif 12'
gsettings set org.gnome.desktop.interface document-font-name 'sans-serif 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'monospace 12'
