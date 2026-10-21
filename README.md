# Lula Light

A **light** Omarchy theme in the Lula family: warm paper surfaces tinted
rose, deep wine text, and a darkened red accent that stays readable on
paper. The bright sibling of
[Lula (dark)](https://github.com/PedroAugustoOK/omarchy-lula-theme).

![Lula Light preview](preview.png)

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
| `accent` / `red` | `#B62A3E` | one accent, wine red, 5.3:1 on paper |
| `selection` | `#EFDADE` | rose selection |
| `muted` | `#B79AA1` | soft borders (3.97:1, chrome only) |

Panel/ANSI contrast (same calculator as `omarchy-theme-preview`):
every ANSI color ≥ 4.57:1 on the background; `bright_*` are slightly
lightened siblings (3.84:1 for `bright_magenta`, chrome-grade like the
official light themes' weakest entries).

## Wallpapers

Three 2560×1440 abstract wallpapers in `backgrounds/` (cycle with
`Super + Ctrl + Space`). The light counterpart to the dark set: soft rose
on warm paper, no imagery, in the same quiet, blurred language as
[Veredas](https://github.com/PedroAugustoOK/omarchy-veredas-theme).

| Wallpaper | Description |
|---|---|
| ![01 Lula Light Blush](backgrounds/001-lula-light-blush.png) `001-lula-light-blush.png` | Morning light on warm paper, with rose in the corners |
| ![02 Lula Light Petal](backgrounds/002-lula-light-petal.png) `002-lula-light-petal.png` | A pale rose halo, barely there |
| ![03 Lula Light Linen](backgrounds/003-lula-light-linen.png) `003-lula-light-linen.png` | A diagonal rose wash on linen cream |

PNG, 150–205 KB each. Original abstract artwork generated
programmatically with ImageMagick; no third-party imagery. Nothing
animated.

## Installation

```bash
omarchy theme install https://github.com/PedroAugustoOK/omarchy-lula-light-theme
```

Clones to `~/.config/omarchy/themes/lula-light` and applies immediately
(`Install > Style > Theme`).

## Activation

```bash
omarchy theme list            # confirm `lula-light` is listed
omarchy theme set lula-light
omarchy theme current         # should print `Lula Light`
omarchy theme bg next         # cycle the three wallpapers
```

Preview the palette without applying:

```bash
omarchy dev theme-preview lula-light
```

## Update and removal

```bash
omarchy theme update             # pull latest for all git-installed themes
omarchy theme refresh            # re-apply the current theme after an Omarchy upgrade
omarchy theme remove lula-light
```

After an `omarchy update`, run `omarchy theme refresh` once so staged
configs are regenerated with the current templates.

To go back to the dark sibling: `omarchy theme set lula`.

## Optional extras (machine-local)

- **Plymouth boot screen**:
  `omarchy-plymouth-set-by-theme lula-light` (uses this theme's
  `unlock.png` + `background`/`foreground`; asks for sudo; revert with
  `omarchy plymouth reset`). The rendered key art
  (`preview-unlock.png`) is 1920×1080.

## Compatibility

- Omarchy **4.x**, tested on `4.0.5-1`.
- Ships no `.lua`, no terminal configs, no `vscode.json`, no symlinks —
  nothing is dropped by git-theme staging.
- Icons `Yaru-red`; keyboard backlight red `e63950`.
- No animated `backgrounds/intros/` (the OWE wallpaper engine is optional
  and the theme stays static).

## Repository structure

```text
omarchy-lula-light-theme/
├── colors.toml          # the palette — the only required file
├── backgrounds/         # 3 abstract 2560×1440 wallpapers
├── icons.theme          # Yaru-red
├── keyboard.rgb         # e63950
├── preview.png          # 1800×1012 theme-picker artwork
├── unlock.png           # transparent lock/boot art
├── preview-unlock.png   # 1920×1080 lock/boot styles preview
├── scripts/             # make-preview.sh, generates preview.png
├── README.md
├── RESEARCH.md          # light-mode conventions + measured contrast
└── LICENSE              # MIT
```

## License

MIT — see [LICENSE](LICENSE).
