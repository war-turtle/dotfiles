-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
-- This is where you actually apply your config choices

config.color_scheme = "Tokyo Night"
config.default_prog = { os.getenv("SHELL"), "-l" }
config.enable_tab_bar = false
config.window_background_opacity = 0.9
config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = true })
config.font_size = 15.0

-- and finally, return the configuration to wezterm
return config
