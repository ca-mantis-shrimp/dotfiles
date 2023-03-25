local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "nord"
config.font = wezterm.font("Monoid NF")
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
return config
