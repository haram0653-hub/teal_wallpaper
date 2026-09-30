-- ╔══════════════════════════════════════╗
-- ║         HYPRLAND CONFIG              ║
-- ║   Teal & Pink · Sharp · Anime        ║
-- ╚══════════════════════════════════════╝
--
-- Lua config (Hyprland >= 0.56). Shared between machines:
-- hardware-specific bits are detected at load time below.

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true end
    return false
end

local home = os.getenv("HOME")

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd(home .. "/.config/hypr/launch-wob.sh")

    -- Polkit agent: password prompts for GUI apps (mounting drives in Thunar, etc.)
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Clipboard history (text and images)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Obsidian git sync on close (script lives outside the repo; only on machines that have it)
    local obsidianWatch = home .. "/.local/bin/obsidian-watch.sh"
    if file_exists(obsidianWatch) then
        hl.exec_cmd(obsidianWatch)
    end
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Nvidia: only applied when the proprietary driver is loaded (desktop).
-- The laptop uses Intel graphics and skips these.
if file_exists("/proc/driver/nvidia/version") then
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
    hl.env("GBM_BACKEND", "nvidia-drm")
    hl.env("NVD_BACKEND", "direct")
end

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------
---- MONITOR ----
-----------------

-- Any output, highest refresh rate (240Hz on the desktop, native panel on the laptop)
hl.monitor({
    output   = "",
    mode     = "highrr",
    position = "auto",
    scale    = 1,
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 6,
        gaps_out = 16,
        border_size = 1,
        col = {
            active_border   = "rgba(F2A7B8ff)",
            inactive_border = "rgba(6BBFB560)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 4,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 0.96,

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 2,
            vibrancy = 0.1696,
        },

        shadow = {
            enabled        = true,
            range          = 24,
            render_power   = 2,
            color          = "rgba(6BBFB525)",
            color_inactive = "rgba(6BBFB510)",
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "pavucontrol" },
    float = true,
})

hl.window_rule({
    name  = "float-nm",
    match = { class = "nm-connection-editor" },
    float = true,
})

hl.window_rule({
    name  = "float-pip",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin   = true,
})

hl.window_rule({
    name    = "opacity-kitty",
    match   = { class = "kitty" },
    opacity = 0.92,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Core
hl.bind(mainMod .. " + RETURN",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",           hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + B",   hl.dsp.exec_cmd("pkill -SIGUSR2 -x waybar || waybar"))

-- Session
hl.bind("ALT + F4",                  hl.dsp.exec_cmd("wlogout -b 3 -c 350 -r 60 -p layer-shell"))
hl.bind(mainMod .. " + L",           hl.dsp.exec_cmd("hyprlock"))

-- Notifications
hl.bind(mainMod .. " + SHIFT + N",   hl.dsp.exec_cmd("swaync-client -t"))

-- Clipboard history
hl.bind(mainMod .. " + V",           hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

-- Screenshots
hl.bind("PRINT",                     hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures"))
hl.bind("SHIFT + PRINT",             hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures"))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap windows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Resize windows
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -40, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true })

-- Workspaces: SUPER + [0-9] switch, SUPER + SHIFT + [0-9] move window
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window control
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume (pushes the new level to the wob OSD; 0 when muted)
local wobVolume = "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print ($3 == \"[MUTED]\") ? 0 : int($2*100)}' > $XDG_RUNTIME_DIR/wob.sock"

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && " .. wobVolume), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && " .. wobVolume),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && " .. wobVolume),     { locked = true })

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Brightness (also pushed to the wob OSD)
local wobBrightness = "brightnessctl -m | cut -d, -f4 | tr -d % > $XDG_RUNTIME_DIR/wob.sock"

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && " .. wobBrightness), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && " .. wobBrightness), { locked = true, repeating = true })
