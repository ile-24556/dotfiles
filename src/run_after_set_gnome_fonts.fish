if not command -v gsettings
    return
end

gsettings set org.gnome.desktop.interface font-name 'ui-sans-serif 14'
gsettings set org.gnome.desktop.interface document-font-name 'sans-serif 14'
gsettings set org.gnome.desktop.interface monospace-font-name 'monospace 16'
