# Crimson Light

A **light** Omarchy theme in the Crimson family: warm paper surfaces tinted
rose, deep wine text, and a darkened crimson accent that stays readable on
paper. The bright sibling of
[Crimson (dark)](https://github.com/PedroAugustoOK/omarchy-crimson-theme).

![Crimson Light preview](preview.png)

## Palette

Every generated config — Hyprland borders, the shell (bar, menus, launcher,
notifications, OSD, lock screen), Alacritty/Foot/Ghostty/Kitty, btop,
Chromium, Neovim, Helix, VS Code, Obsidian, Claude/Pi/Hermes/T3Code, tmux,
GNOME and the keyboard backlight — derives from `colors.toml` through
Omarchy's built-in templates.

| Key | Value | Role |
|---|---|---|
| `mode` | `light` | paper surfaces, dark text |
| `background` | `#F9F2F4` | warm rose paper (text 15.02:1) |
| `foreground` | `#32161C` | deep wine ink |
| `accent` / `red` | `#B62A3E` | one accent, crimson, 5.3:1 on paper |
| `selection` | `#EFDADE` | rose selection |
| `muted` | `#B79AA1` | soft borders (3.97:1, chrome only) |

Panel/ANSI contrast (same calculator as `omarchy-theme-preview`):
every ANSI color ≥ 4.57:1 on the background; `bright_*` are slightly
lightened siblings (3.84:1 for `bright_magenta`, chrome-grade like the
official light themes' weakest entries).

## Wallpapers

Three 2560×1440 originals in `backgrounds/` (cycle with `Super + Ctrl +
Space`), the light twins of the dark theme's motifs:

| Wallpaper | Description |
|---|---|
| ![01 Crimson Light Minimal](backgrounds/001-crimson-light-minimal.png) `001-crimson-light-minimal.png` | Flat paper, crimson horizon line, ring-and-dot mark |
| ![02 Crimson Light Dawn](backgrounds/002-crimson-light-dawn.jpg) `002-crimson-light-dawn.jpg` | Pale dawn gradient, hazy crimson sun, layered ridges |
| ![03 Crimson Light Abstract](backgrounds/003-crimson-light-abstract.jpg) `003-crimson-light-abstract.jpg` | Pale bands with wine and crimson bezier sweeps |

All under ~100 KB. Nothing animated.

## Installation

```bash
omarchy theme install https://github.com/PedroAugustoOK/omarchy-crimson-light-theme
```

Clones to `~/.config/omarchy/themes/crimson-light` and applies immediately
(`Install > Style > Theme`).

## Activation

```bash
omarchy theme list            # confirm `crimson-light` is listed
omarchy theme set crimson-light
omarchy theme current         # should print `Crimson Light`
omarchy theme bg next         # cycle the three wallpapers
```

Preview the palette without applying:

```bash
omarchy dev theme-preview crimson-light
```

## Update and removal

```bash
omarchy theme update             # pull latest for all git-installed themes
omarchy theme refresh            # re-apply the current theme after an Omarchy upgrade
omarchy theme remove crimson-light
```

After an `omarchy update`, run `omarchy theme refresh` once so staged
configs are regenerated with the current templates.

To go back to the dark sibling: `omarchy theme set crimson`.

## Optional extras (machine-local)

- **Plymouth boot screen**:
  `omarchy-plymouth-set-by-theme crimson-light` (uses this theme's
  `unlock.png` + `background`/`foreground`; asks for sudo; revert with
  `omarchy plymouth reset`). The rendered key art
  (`preview-unlock.png`) is 1920×1080.

## Compatibility

- Omarchy **4.x**, tested on `4.0.5-1`.
- Ships no `.lua`, no terminal configs, no `vscode.json`, no symlinks —
  nothing is dropped by git-theme staging.
- Icons `Yaru-red`; keyboard backlight crimson `e63950`.
- No animated `backgrounds/intros/` (the OWE wallpaper engine is optional
  and the theme stays static).

## Repository structure

```text
omarchy-crimson-light-theme/
├── colors.toml          # the palette — the only required file
├── backgrounds/         # 3 original light wallpapers
├── icons.theme          # Yaru-red
├── keyboard.rgb         # e63950
├── preview.png          # 1800×1012 theme-picker thumbnail (real screenshot)
├── unlock.png           # transparent lock/boot art
├── preview-unlock.png   # 1920×1080 lock/boot styles preview
├── README.md
├── RESEARCH.md          # light-mode conventions + measured contrast
└── LICENSE              # MIT
```

## License

MIT — see [LICENSE](LICENSE).
