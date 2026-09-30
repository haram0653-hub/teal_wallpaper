# teal_wallpaper dotfiles

> Hyprland rice · Teal & Pink Anime · Sharp Minimalist
>
> Palette sourced from a cozy anime wallpaper — muted teal background,
> soft pink accents, pale teal-white surfaces.

---

## Color Palette

| Role        | Hex       | Description     |
|-------------|-----------|-----------------|
| Background  | `#6BBFB5` | Muted teal      |
| Surface     | `#EFF8F7` | Pale teal-white |
| Surface alt | `#D9EFED` | Deeper teal     |
| Pink accent | `#F2A7B8` | Soft pink       |
| Pink dim    | `#c47f93` | Dark pink       |
| Text        | `#2C3E3D` | Deep teal-dark  |

---

## Stack

### Core
| App       | Role                    | Source  |
|-----------|-------------------------|---------|
| Hyprland  | Wayland compositor / WM | `extra` |
| Hyprpaper | Wallpaper daemon        | `extra` |
| Hypridle  | Idle daemon             | `extra` |
| Hyprlock  | Lock screen             | `extra` |
| hyprpolkitagent | Polkit auth prompts | `extra` |
| xdg-desktop-portal-hyprland | Screen sharing | `extra` |

### Bar & Launcher
| App    | Role                       | Source  |
|--------|----------------------------|---------|
| Waybar | Status bar (floating pill) | `AUR` (`waybar-git`) |
| Rofi   | App launcher               | `extra` |

### Terminal
| App      | Role              | Source  |
|----------|-------------------|---------|
| Kitty    | Terminal emulator | `extra` |
| Starship | Shell prompt      | `extra` |

### Notifications
| App    | Role                         | Source  |
|--------|------------------------------|---------|
| Swaync | Notification daemon + center | `extra` |

### System Info & Monitoring
| App       | Role              | Source  |
|-----------|-------------------|---------|
| Fastfetch | System info fetch | `extra` |
| Btop      | Resource monitor  | `extra` |

### Volume OSD
| App | Role                            | Source  |
|-----|---------------------------------|---------|
| Wob           | Volume / brightness overlay bar | `extra` |
| Brightnessctl | Backlight control               | `extra` |

### Power Menu
| App     | Role                          | Source |
|---------|-------------------------------|--------|
| Wlogout | Graphical logout / power menu | `AUR`  |

### Calendar
| App        | Role                   | Source  |
|------------|------------------------|---------|
| Gsimplecal | Minimal calendar popup | `extra` |

### Media
| App       | Role                    | Source  |
|-----------|-------------------------|---------|
| Playerctl | Media player controller | `extra` |

### Screenshot
| App      | Role            | Source |
|----------|-----------------|--------|
| Hyprshot | Screenshot tool | `extra` |

### Clipboard
| App          | Role                          | Source  |
|--------------|-------------------------------|---------|
| wl-clipboard | Wayland clipboard CLI         | `extra` |
| Cliphist     | Clipboard history (rofi menu) | `extra` |

### Music
| App       | Role                 | Source |
|-----------|----------------------|--------|
| Spotify   | Music streaming      | `AUR`  |
| Spicetify | Spotify theme engine | manual |

### Fonts
| Font                  | Used in             | Source                      |
|-----------------------|---------------------|-----------------------------|
| JetBrainsMono Nerd Font | Kitty, Waybar, Rofi, Starship | `ttf-jetbrains-mono-nerd` |
| Geist Mono (fallback) | Waybar              | `ttf-geist-mono` (AUR)      |

---

## Dependencies

```bash
# Official repos
sudo pacman -S hyprland hyprpaper hypridle hyprlock hyprpolkitagent \
               xdg-desktop-portal-hyprland rofi kitty swaync fastfetch \
               btop playerctl gsimplecal starship thunar wireplumber wob \
               hyprshot brightnessctl wl-clipboard cliphist \
               ttf-jetbrains-mono-nerd spotify

# AUR
yay -S wlogout ttf-geist-mono waybar-git

# Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
```

---

## File Structure

```
dotfiles/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.lua          # Main Hyprland config (Lua, Hyprland >= 0.56)
│   │   ├── hyprpaper.conf        # Wallpaper config
│   │   ├── hyprlock.conf         # Lock screen config
│   │   ├── hypridle.conf         # Idle daemon config
│   │   ├── launch-wob.sh         # WOB volume OSD launcher
│   │   ├── volume.sh             # Volume up/down/mute + WOB OSD (keybinds and waybar)
│   │   └── wallpaper/
│   │       └── wallpaper.png     # Wallpaper (not tracked by git)
│   ├── waybar/
│   │   ├── config                # Waybar modules config
│   │   └── style.css             # Waybar theme
│   ├── rofi/
│   │   └── config.rasi           # Rofi launcher theme
│   ├── kitty/
│   │   └── kitty.conf            # Kitty terminal theme
│   ├── starship/
│   │   └── starship.toml         # Starship prompt theme
│   ├── fastfetch/
│   │   └── config.jsonc          # Fastfetch layout and colors
│   ├── btop/
│   │   ├── btop.conf             # Btop config
│   │   └── themes/
│   │       └── teal-anime.theme  # Btop teal pink theme
│   ├── wob/
│   │   └── wob.ini               # Volume OSD theme
│   ├── wlogout/
│   │   ├── layout                # Power menu button layout
│   │   └── style.css             # Power menu theme
│   ├── swaync/
│   │   ├── config.json           # Swaync config
│   │   └── style.css             # Swaync notification theme
│   ├── spicetify/
│   │   └── Themes/
│   │       └── TealAnime/
│   │           ├── color.ini     # Spotify color scheme
│   │           └── user.css      # Spotify custom CSS
│   └── gtk-3.0/
│       └── gtk.css               # GTK app theming (gsimplecal etc.)
├── .gitignore
└── README.md
```

---

## Install

### 1. Clone the repo

```bash
git clone https://github.com/haram0653-hub/teal_wallpaper.git
cd teal_wallpaper/dotfiles
```

### 2. Install dependencies

```bash
sudo pacman -S hyprland hyprpaper hypridle hyprlock hyprpolkitagent \
               xdg-desktop-portal-hyprland rofi kitty swaync fastfetch \
               btop playerctl gsimplecal starship thunar wireplumber wob \
               hyprshot brightnessctl wl-clipboard cliphist \
               ttf-jetbrains-mono-nerd spotify

yay -S wlogout ttf-geist-mono waybar-git

# Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
source ~/.bashrc
```

### 3. Symlink configs

```bash
DOTFILES=$(pwd)

ln -s $DOTFILES/.config/hypr      ~/.config/hypr
ln -s $DOTFILES/.config/waybar    ~/.config/waybar
ln -s $DOTFILES/.config/rofi      ~/.config/rofi
ln -s $DOTFILES/.config/kitty     ~/.config/kitty
ln -s $DOTFILES/.config/starship  ~/.config/starship
ln -s $DOTFILES/.config/fastfetch ~/.config/fastfetch
ln -s $DOTFILES/.config/btop      ~/.config/btop
ln -s $DOTFILES/.config/wob       ~/.config/wob
ln -s $DOTFILES/.config/wlogout   ~/.config/wlogout
ln -s $DOTFILES/.config/swaync    ~/.config/swaync
ln -s $DOTFILES/.config/gtk-3.0   ~/.config/gtk-3.0
```

### 4. Enable Starship in shell

```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

### 5. Add wallpaper

```bash
mkdir -p ~/.config/hypr/wallpaper
cp /path/to/your/wallpaper.png ~/.config/hypr/wallpaper/wallpaper.png
```

### 6. Make scripts executable

```bash
chmod +x ~/.config/hypr/launch-wob.sh ~/.config/hypr/volume.sh
```

### 7. Apply Spicetify theme

```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify backup apply

mkdir -p ~/.config/spicetify/Themes/TealAnime
cp $DOTFILES/.config/spicetify/Themes/TealAnime/color.ini ~/.config/spicetify/Themes/TealAnime/
cp $DOTFILES/.config/spicetify/Themes/TealAnime/user.css ~/.config/spicetify/Themes/TealAnime/

spicetify config current_theme TealAnime
spicetify config color_scheme TealAnime
spicetify apply
```

### 8. Launch Hyprland

```bash
Hyprland
```

---

## Keybinds

### Window Management
| Keys                 | Action           |
|----------------------|------------------|
| `SUPER + Return`     | Open Kitty       |
| `SUPER + Q`          | Kill window      |
| `SUPER + F`          | Fullscreen       |
| `SUPER + T`          | Toggle float     |
| `SUPER + P`          | Pseudo tile      |
| `SUPER + J`          | Toggle split     |
| `SUPER + S`          | Scratchpad       |
| `SUPER + SHIFT + S`  | Move to scratchpad |
| `SUPER + LMB drag`   | Move window      |
| `SUPER + RMB drag`   | Resize window    |
| `SUPER + Arrow keys` | Move focus       |
| `SUPER + SHIFT + Arrows` | Swap window  |
| `SUPER + CTRL + Arrows`  | Resize window |

### Apps
| Keys                | Action                        |
|---------------------|-------------------------------|
| `SUPER + Space`     | Rofi launcher                 |
| `SUPER + E`         | File manager (Thunar)         |
| `SUPER + L`         | Lock screen (hyprlock)        |
| `ALT + F4`          | Power menu (wlogout)          |
| `SUPER + M`         | Exit Hyprland                 |
| `SUPER + SHIFT + N` | Notification center (swaync)  |
| `SUPER + V`         | Clipboard history (cliphist)  |
| `SUPER + SHIFT + B` | Reload Waybar                 |

### Workspaces
| Keys                  | Action            |
|-----------------------|-------------------|
| `SUPER + 1–0`         | Switch workspace  |
| `SUPER + SHIFT + 1–0` | Move to workspace |
| 3-finger swipe        | Switch workspace  |
| `SUPER + scroll`      | Cycle workspaces  |

### Media & System
| Keys                      | Action              |
|---------------------------|---------------------|
| `Print`                   | Screenshot window   |
| `SHIFT + Print`           | Screenshot region   |
| `FN + Vol Up/Down`        | Volume + WOB OSD    |
| `FN + Mute`               | Toggle mute + WOB OSD |
| `FN + Play/Pause`         | Media play/pause    |
| `FN + Next/Prev`          | Media next/previous |
| `FN + Brightness Up/Down` | Brightness + WOB OSD |

---

## Theme Switcher

Switch between themes using the switcher script:

```bash
~/Projects/theme-switch.sh
```

Options:
- `1` — Classic theme (groot wallpaper)
- `2` — Teal Anime theme (this rice)

The script automatically relinks all symlinks, changes the wallpaper and restarts waybar.

---

## Notes

- Hyprland config is **Lua** (`hyprland.lua`), which needs Hyprland 0.56 or newer. Hyprlock, hypridle and hyprpaper still use `.conf`
- The config is shared across machines: NVIDIA env vars are applied only when the NVIDIA driver is loaded, and the monitor uses the highest refresh rate on any output
- Autostart also launches the polkit agent (`hyprpolkitagent` user service) and cliphist watchers for text and images
- `SUPER + SHIFT + B` reloads Waybar in place (`SIGUSR2`), or starts it if it isn't running. After upgrading waybar itself, `pkill -x waybar` first so the new binary starts
- Any `hyprctl dispatch` in other configs (hypridle, wlogout) must use Lua syntax, e.g. `hyprctl dispatch 'hl.dsp.dpms({ action = "off" })'`; the old `hyprctl dispatch dpms off` form is rejected
- The power menu has no Hibernate button: this laptop only has zram swap, so there is nowhere to write the hibernation image
- Waybar must be **`waybar-git`** until a release newer than 0.15.0: 0.15.0 sends legacy dispatch commands that Hyprland's Lua IPC rejects, so clicking workspace numbers silently does nothing ([Waybar#5008](https://github.com/Alexays/Waybar/issues/5008)). Switch back to `waybar` from `extra` once a fixed release ships
- Validate changes with `Hyprland --verify-config -c ~/.config/hypr/hyprland.lua`
- The Obsidian git-sync watcher (`~/.local/bin/obsidian-watch.sh`) is not in the repo; it only starts if that file exists
- Spicetify theme is **not symlinked** — copy it manually after cloning (see step 7)
- Wallpaper is **not tracked by git** — add it manually after cloning (see step 5)
- Theme switcher script lives at `~/Projects/theme-switch.sh` — not inside the dotfiles repo
- Starship prompt requires `eval "$(starship init bash)"` in `~/.bashrc`
