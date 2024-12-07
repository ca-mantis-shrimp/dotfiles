local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local act = wezterm.action

config.color_scheme = "nord"
config.font = wezterm.font("JetBrains Mono")
if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "pwsh", "-ExecutionPolicy", "RemoteSigned" }
else
	config.default_prog = { "bash" }
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
	local process_name = basename(pane:get_foreground_process_name())
	return process_name == "nvim.exe" or process_name == "vim.exe"
end

config.leader = { key = "Space", mods = "CTRL|SHIFT" }

local keymaps = {}

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

table.insert(keymaps, split_nav("resize", "h"))
table.insert(keymaps, split_nav("resize", "j"))
table.insert(keymaps, split_nav("resize", "k"))
table.insert(keymaps, split_nav("resize", "l"))

table.insert(keymaps, split_nav("move", "h"))
table.insert(keymaps, split_nav("move", "j"))
table.insert(keymaps, split_nav("move", "k"))
table.insert(keymaps, split_nav("move", "l"))

table.insert(keymaps, {
	key = "p",
	mods = "CTRL|ALT",
	action = act.ActivateCommandPalette,
})

table.insert(keymaps, { key = "s", mods = "LEADER", action = act.QuickSelect })

table.insert(keymaps, {
	key = "c",
	mods = "LEADER",
	action = act.CloseCurrentPane({
		confirm = true,
	}),
})

table.insert(keymaps, {
	key = "l",
	mods = "LEADER",
	action = act.ShowLauncher,
})

table.insert(keymaps, {
	key = "Enter",
	mods = "ALT",
	action = act.DisableDefaultAssignment,
})

table.insert(keymaps, { key = "F11", action = act.ToggleFullScreen })

config.keys = keymaps
return config
