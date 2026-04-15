# Check formats of template-generated config files

cd (mktemp -d)

cp $XDG_DATA_HOME/chezmoi/.dprint.jsonc

cp $XDG_CONFIG_HOME/firefox_relay_point/user.js firefox_user.js
cp $XDG_CONFIG_HOME/fontconfig/fonts.conf font_conf.xml
cp $XDG_CONFIG_HOME/mise/config.toml mise_config.toml
cp $XDG_CONFIG_HOME/zed/settings.json zed_settings.jsonc

dprint check
