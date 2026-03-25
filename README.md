# teal_wallpaper dotfiles

> Hyprland rice · Teal & Pink Anime · Sharp Minimalist
>
> Palette sourced from a cozy anime wallpaper — muted teal background,
> soft pink accents, pale teal-white surfaces.

---

## Preview

| Role        | Hex       | Preview         |
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
| App          | Role                        | Source     |
|--------------|-----------------------------|------------|
| Hyprland     | Wayland compositor / WM     | `extra`    |
| Hyprpaper    | Wallpaper daemon            | `extra`    |
| Hypridle     | Idle daemon                 | `extra`    |

### Bar & Launcher
| App     | Role                              | Source  |
|---------|-----------------------------------|---------|
| Waybar  | Status bar (floating pill)        | `extra` |
| Rofi    | App launcher                      | `extra` |

### Terminal
| App     | Role                              | Source  |
|---------|-----------------------------------|---------|
| Kitty   | Terminal emulator                 | `extra` |

### Notifications
| App    | Role                              | Source  |
|--------|-----------------------------------|---------|
| Swaync | Notification daemon + center      | `extra` |

### System Info
| App        | Role                          | Source  |
|------------|-------------------------------|---------|
| Fastfetch  | System info fetch             | `extra` |

### Volume OSD
| App  | Role                               | Source  |
|------|------------------------------------|---------|
| Wob  | Volume / brightness overlay bar    | `extra` |

### Power Menu
| App     | Role                              | Source |
|---------|-----------------------------------|--------|
| Wlogout | Graphical logout / power menu     | `AUR`  |

### Calendar
| App         | Role                          | Source  |
|-------------|-------------------------------|---------|
| Gsimplecal  | Minimal calendar popup        | `extra` |

### Media
| App        | Role                           | Source  |
|------------|--------------------------------|---------|
| Playerctl  | Media player controller        | `extra` |

### Screenshot
| App        | Role                           | Source  |
|------------|--------------------------------|---------|
| Hyprshot   | Screenshot tool                | `AUR`   |

### Fonts
| Font                  | Used in                    | Source             |
|-----------------------|----------------------------|--------------------|
| JetBrains Mono        | Kitty, Waybar, Rofi        | `ttf-jetbrains-mono` |
| Geist Mono (fallback) | Waybar                     | `ttf-geist-mono-nerd` |

---

## Dependencies

Install all at once:

```bash
# Official repos
sudo pacman -S hyprland hyprpaper hypridle waybar rofi kitty \
               swaync fastfetch playerctl gsimplecal \
               ttf-jetbrains-mono brightnessctl

# AUR
yay -S wlogout wob ttf-geist-mono-nerd hyprshot
```

---

## File Structure

```
dotfiles/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf       # Main Hyprland config
│   │   ├── hyprpaper.conf      # Wallpaper config
│   │   ├── launch-wob.sh       # WOB volume OSD launcher
│   │   └── wallpaper/
│   │       └── wallpaper.png   # Wallpaper (not tracked by git)
│   ├── waybar/
│   │   ├── config              # Waybar modules config
│   │   └── style.css           # Waybar theme
│   ├── rofi/
│   │   └── config.rasi         # Rofi launcher theme
│   ├── kitty/
│   │   └── kitty.conf          # Kitty terminal theme
│   ├── fastfetch/
│   │   └── config.jsonc        # Fastfetch layout and colors
│   ├── wob/
│   │   └── wob.ini             # Volume OSD theme
│   ├── wlogout/
│   │   ├── layout              # Power menu button layout
│   │   └── style.css           # Power menu theme
│   └── gtk-3.0/
│       └── gtk.css             # GTK app theming (gsimplecal etc.)
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
sudo pacman -S hyprland hyprpaper hypridle waybar rofi kitty \
               swaync fastfetch playerctl gsimplecal \
               ttf-jetbrains-mono brightnessctl

yay -S wlogout wob ttf-geist-mono-nerd hyprshot
```

### 3. Symlink configs

```bash
ln -s $(pwd)/.config/hypr      ~/.config/hypr
ln -s $(pwd)/.config/waybar    ~/.config/waybar
ln -s $(pwd)/.config/rofi      ~/.config/rofi
ln -s $(pwd)/.config/kitty     ~/.config/kitty
ln -s $(pwd)/.config/fastfetch ~/.config/fastfetch
ln -s $(pwd)/.config/wob       ~/.config/wob
ln -s $(pwd)/.config/wlogout   ~/.config/wlogout
```

### 4. Add wallpaper

```bash
cp /path/to/your/wallpaper.png ~/.config/hypr/wallpaper/wallpaper.png
```

### 5. Make scripts executable

```bash
chmod +x ~/.config/hypr/launch-wob.sh
```

### 6. Launch Hyprland

```bash
Hyprland
```

---

## Keybinds

| Keys                | Action                    |
|---------------------|---------------------------|
| `SUPER + Return`    | Open Kitty                |
| `SUPER + Space`     | Rofi launcher             |
| `SUPER + Q`         | Kill window               |
| `SUPER + F`         | Fullscreen                |
| `SUPER + T`         | Toggle float              |
| `SUPER + E`         | File manager (Dolphin)    |
| `SUPER + P`         | Pseudo tile               |
| `SUPER + J`         | Toggle split              |
| `SUPER + S`         | Scratchpad                |
| `SUPER + SHIFT + E` | Power menu (wlogout)      |
| `SUPER + SHIFT + B` | Reload Waybar             |
| `SUPER + 1–9`       | Switch workspace          |
| `SUPER + SHIFT + 1–9` | Move to workspace       |
| `Print`             | Screenshot region         |
| `SHIFT + Print`     | Screenshot window         |
| `FN + Vol Up/Down`  | Volume + WOB OSD          |
| `FN + Mute`         | Toggle mute               |
| `FN + Play/Pause`   | Media play/pause          |
| `FN + Next/Prev`    | Media next/previous       |

---

## Theme Switcher

A bash script to switch between themes is available at `~/Projects/theme-switch.sh`:

```bash
~/Projects/theme-switch.sh
```

Options:
- `1` — Classic theme
- `2` — Teal Anime theme (this rice)
