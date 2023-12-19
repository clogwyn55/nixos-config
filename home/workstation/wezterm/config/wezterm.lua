-- define variables
local wezterm = require 'wezterm'
local config = {}
-- helps provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end
-- config choices
config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font 'FiraCodeNerdFont'
config.font_size = 10
config.window_background_opacity = 0.8

return config
