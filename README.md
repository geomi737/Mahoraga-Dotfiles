# ⚠️ Mahoraga Dotfiles

> **DEV BRANCH – Possible bugs!**

These dotfiles are created for both **personal** and **public** use.  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details..

**Why "Mahoraga"?**  
Because the setup adapts dynamically to the wallpaper set via **Waypaper**.

# ⌛Installation

## Download & Install

```
git clone https://github.com/geomi737/Mahoraga-Dotfiles.git -b dev
cd Mahoraga-Dotfiles
./install.sh
```

Then answer the questions

## After reboot

- QT and GTK themes **don’t** set automatically. You need to set them **manually** the first time, then they will change themselves **automatically**. You can do this by pressing Win (MainMod) + R, typing GTK or QT5/QT6, and choosing the theme.

- Firefox requires a special extension called Pywalfox. You can install it here: https://addons.mozilla.org/en-US/firefox/addon/pywalfox/

- VSCode also requires an extension called Wal Theme. Install it and choose the theme — it will set automatically.

- BTOP needs the theme to be set manually. Open BTOP by pressing Win (MainMod) + R, search for btop, launch it, press Escape, and choose the theme.

---

## 🔑 Keybindings

| Shortcut      | Action           |
| ------------- | ---------------- |
| `mainmod + Q` | Open Terminal    |
| `mainmod + W` | Reload Waybar    |
| `mainmod + E` | File Manager     |
| `mainmod + R` | Application Menu |
| `mainmod + V` | Clipboard        |
| `mainmod + M` | Logout to DM     |
| `mainmod + S` | Extra Workspace  |
| `mainmod + C` | Close Window     |
| `mainmod + H` | Change Wallpaper |

---

## 💻 Terminal Commands

| Command             | Description       |
| ------------------- | ----------------- |
| `install <package>` | Install a package |
| `remove <package>`  | Remove a package  |
| `cleanup`           | Clear cache       |
| `update`            | Update packages   |

---

## 📋 Changing Ones

**Used (AUR):**

- `matugen` (color generation)
- `pywal16` (colorscheme integration)
- `spicetify` (Spotify theming)
- `waypaper` (wallpaper management)

**Edited / Customized:**

- **Waybar** → style, padding, colors, transparency
- **swww** → integrated with Waypaper for live wallpaper changes
- **GTK3 & GTK4** → global themes recolored with Matugen/Pywal16
- **Qt5 & Qt6** → applied theme/colors via Kvantum and configs
- **Spotify** → themed with Spicetify
- **Kitty** → terminal theme, font, transparency
- **Wofi** → launcher theme and layout
- **CopyQ** → recolored + keybinding integration
- **Hyprlock** → lockscreen styling
- **Hyprland (outline)** → config adjustments (borders, gaps, rules)
- **Dunst** → notifications theme, opacity
- **Pywalfox** → Firefox theme sync
- **Cava** → color scheme adapted
- **Btop** → recolored, custom theme applied
- **VSCode** → custom theme synced with Pywal16
- **VLC** → Thanks QT

**Notes:**

- Might have forgotten something…
- Actually, **GTK and Qt changes affect most apps** anyway.

---

## 🖼️ Preview

> _(Screenshots go here – e.g. Waybar, Wallpaper, Terminal, etc.)_

![preview](/Preview/1.png)
![preview](/Preview/2.png)
![preview](/Preview/3.png)

---

## 📌 Notes

- This is a **development branch**, expect unfinished features.
- Feedback and suggestions are welcome!

##  In future list

- **Vim**
