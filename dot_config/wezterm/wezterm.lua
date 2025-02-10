-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
-- This is where you actually apply your config choices

config.default_prog = { '/usr/bin/zsh' }
config.enable_tab_bar = false
config.window_background_opacity = 0.8
config.font = wezterm.font 'JetBrains Mono'

-- and finally, return the configuration to wezterm
return config