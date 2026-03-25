local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'nord'

config.default_prog = { 'pwsh.exe' }

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'JetBrains Mono NF',
  'IBM Plex Sans JP',
  'Noto Emoji',
}
config.font_size = 14
config.line_height = 1.2

return config
