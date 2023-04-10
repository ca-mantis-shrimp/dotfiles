local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local act = wezterm.action
config.color_scheme = "nord"
config.font = wezterm.font("Monoid NF")
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-ExecutionPolicy", "RemoteSigned" }

local activate_command_palette_keymap = {
  key = 'p',
  mods = 'CTRL|ALT',
  action = act.ActivateCommandPalette,
}
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

config.leader = { key = "Space", mods = "CTRL|SHIFT" }
    local resize_pane_keymap = {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
    }),
  }
local resize_pane_key_table = {
  { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
  { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

  { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
  { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

  { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
  { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

  { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
  { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

  { key = "Escape", action = "PopKeyTable" },
}
local active_pane_keymap = {
  key = "a",
  mods = "LEADER",
  action = act.ActivateKeyTable({
    name = "activate_pane",
    timeout_milliseconds = 1000,
  }),
}

local activate_pane_key_table = {
  { key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
  { key = "h", action = act.ActivatePaneDirection("Left") },

  { key = "RightArrow", action = act.ActivatePaneDirection("Right") },
  { key = "l", action = act.ActivatePaneDirection("Right") },

  { key = "UpArrow", action = act.ActivatePaneDirection("Up") },
  { key = "k", action = act.ActivatePaneDirection("Up") },

  { key = "DownArrow", action = act.ActivatePaneDirection("Down") },
  { key = "j", action = act.ActivatePaneDirection("Down") },
}

local close_pane_keymap = {
      key = "c",
      mods = "LEADER",
      action = act.CloseCurrentPane({
        confirm = true,
      }),
    }

local show_launcher_keymap = {
  key = "l",
  mods = "LEADER",
  action = act.ShowLauncher,
}

config.keys = {
  resize_pane_keymap,
  active_pane_keymap,
  close_pane_keymap,
  show_launcher_keymap,
  activate_command_palette_keymap
}

config.key_tables = {
  resize_pane = resize_pane_key_table,
  activate_pane = activate_pane_key_table,
}

return config