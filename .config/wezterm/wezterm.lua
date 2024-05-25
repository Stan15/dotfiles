local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Tokyo Night'
-- config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = true


return config
