# Check formats of template-generated config files

cd (mktemp -d)

cp $XDG_DATA_HOME/chezmoi/.dprint.jsonc .

mkdir target
cp $XDG_CONFIG_HOME/chezmoi/chezmoi.toml target/chezmoi.toml
cp $XDG_CONFIG_HOME/firefox_relay_point/user.js target/firefox_user.js
cp $XDG_CONFIG_HOME/fontconfig/fonts.conf target/font_conf.xml
cp $XDG_CONFIG_HOME/mise/config.toml target/mise_config.toml
cp $XDG_CONFIG_HOME/zed/settings.json target/zed_settings.jsonc

for file in target/*
    echo [format_templated_configs.fish] Checking $file ...
    dprint check $file
end
