for prof in $XDG_CONFIG_HOME/mozilla/firefox/*.default*/
    cp -r $XDG_DATA_HOME/chezmoi/manual_install/firefox/* $prof
end
