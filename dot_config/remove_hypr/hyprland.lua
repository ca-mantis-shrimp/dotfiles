local mod      = "SUPER"
local terminal = "uwsm app ghostty"
local browser  = "uwsm app qutebrowser"
local editor   = "uwsm app neovide"
local menu     = "walker"

-- ── autostart ────────────────────────────────────────────────────────────────

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app ashell")
    hl.exec_cmd("uwsm app nwg-dock-hyprland -d")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
end)

-- ── monitors ─────────────────────────────────────────────────────────────────

hl.monitor({ output = "",         mode = "preferred",      position = "auto",     scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144",  position = "0x0",      scale = 1 })
hl.monitor({ output = "DP-2",     mode = "1920x1080",      position = "560x1440", scale = 1 })

-- ── workspace rules ───────────────────────────────────────────────────────────
-- consolidated: gaps + no border/rounding in one rule per selector

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0, border_size = 0, no_rounding = true })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0, border_size = 0, no_rounding = true })

-- ── window rules ─────────────────────────────────────────────────────────────

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- ── config ───────────────────────────────────────────────────────────────────

hl.config({
    general = {
        gaps_in                 = 5,
        gaps_out                = 20,
        border_size             = 2,
        ["col.active_border"]   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
        ["col.inactive_border"] = "rgba(595959aa)",
        resize_on_border        = false,
        allow_tearing           = false,
        layout                  = "dwindle",
    },
    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
    animations = { enabled = true },
    dwindle = {
        preserve_split = true,
    },
    master = { new_status = "master" },
    scrolling = { fullscreen_on_one_column = true },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad     = { natural_scroll = false },
    },
})

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-- ── curves ───────────────────────────────────────────────────────────────────

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1    }, { 0.32, 1   } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1   } } })
hl.curve("linear",         { type = "bezier", points = { { 0,    0    }, { 1,    1   } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5,  0.5  }, { 0.75, 1.0 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0    }, { 0.1,  1   } } })

-- ── animations ───────────────────────────────────────────────────────────────

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default"                         })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint"                    })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint"                    })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear"                    })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear"                    })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick"                           })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint"                    })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade"    })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade"    })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear"                    })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear"                    })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade"    })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade"    })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade"    })

-- ── keybinds ─────────────────────────────────────────────────────────────────

-- apps
hl.bind(mod .. " + Q",       hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B",       hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + E",       hl.dsp.exec_cmd(editor))
hl.bind(mod .. " + R",       hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + ALT + S", hl.dsp.exec_cmd("grim"))

-- window management
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + X", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + V", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- focus (arrows + hjkl)
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + h",     hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + l",     hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + k",     hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + j",     hl.dsp.focus({ direction = "d" }))

-- move windows (arrows) / swap windows (hjkl)
hl.bind(mod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + h",     hl.dsp.window.swap({ direction = "l" }))
hl.bind(mod .. " + SHIFT + l",     hl.dsp.window.swap({ direction = "r" }))
hl.bind(mod .. " + SHIFT + k",     hl.dsp.window.swap({ direction = "u" }))
hl.bind(mod .. " + SHIFT + j",     hl.dsp.window.swap({ direction = "d" }))

-- mouse drag / resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

-- resize (repeatable)
local rep = { ["repeat"] = true }
hl.bind(mod .. " + ALT + left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), rep)
hl.bind(mod .. " + ALT + right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), rep)
hl.bind(mod .. " + ALT + up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), rep)
hl.bind(mod .. " + ALT + down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), rep)
hl.bind(mod .. " + ALT + h",     hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), rep)
hl.bind(mod .. " + ALT + l",     hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), rep)
hl.bind(mod .. " + ALT + k",     hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), rep)
hl.bind(mod .. " + ALT + j",     hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), rep)

-- workspaces: switch + set wallpaper in one bind
local wallpapers = {
    "~/Pictures/Wallpapers/mountain_lake.jpg",
    "~/Pictures/Wallpapers/aurora-borealis.jpg",
    "~/Pictures/Wallpapers/brown-tunnel-near-body-of-water.jpg",
    "~/Pictures/Wallpapers/close-up-of-a-red-siamese-fighting-fish.jpg",
    "~/Pictures/Wallpapers/close-up-photo-of-berries.jpg",
    "~/Pictures/Wallpapers/green-pine-trees-near-body-of-water.jpg",
    "~/Pictures/Wallpapers/macro-photography-of-water-waves.jpg",
    "~/Pictures/Wallpapers/lavender-flower-field-under-pink-sky.jpg",
    "~/Pictures/Wallpapers/silhouette-of-mountains.jpg",
    "~/Pictures/Wallpapers/red-and-black-bird-on-red-flowers.jpg",
}

local ws_keys = { "1","2","3","4","5","6","7","8","9","0" }
for i, wp in ipairs(wallpapers) do
    local key = ws_keys[i]
    hl.bind(mod .. " + " .. key, function()
        hl.dispatch(hl.dsp.focus({ workspace = i }))
        hl.dispatch(hl.dsp.exec_cmd('hyprctl hyprpaper wallpaper "DP-3,' .. wp .. '"'))
    end)
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scroll through workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- special workspace
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- notifications
hl.bind(mod .. " + D",       hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mod .. " + ALT + D", hl.dsp.exec_cmd("makoctl dismiss --all"))

-- voice to text
hl.bind(mod .. " + SHIFT + period", function()
    hl.dispatch(hl.dsp.exec_cmd("pkill -USR2 -x handy"))
    hl.dispatch(hl.dsp.exec_cmd("notify-send -t 2000 'Handy' 'Voice to text toggled'"))
end)

-- media keys (locked = works on lockscreen)
local rep_locked = { ["repeat"] = true, locked = true }
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), rep_locked)
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       rep_locked)
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      rep_locked)
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    rep_locked)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                            rep_locked)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                            rep_locked)
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
