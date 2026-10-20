# RESEARCH — Crimson Light

Engineering notes for the **light** sibling of Crimson.
Verified on **Omarchy 4.0.5-1**. Dark-sibling mechanics (staging flow,
deny list, template resolution, Plymouth, OWE) are documented in the
[Crimson (dark) repo's RESEARCH.md](https://github.com/PedroAugustoOK/omarchy-crimson-theme/blob/main/RESEARCH.md);
this file only registers what is light-specific.

## 1. Light-mode conventions (read from the official themes)

Studied on-disk: `/usr/share/omarchy/themes/catppuccin-latte/colors.toml`
and `/usr/share/omarchy/themes/flexoki-light/colors.toml`.

| Convention | Official behavior | Crimson Light follows it |
|---|---|---|
| `mode` | `"light"` | `"light"` (resolves `theme_type = light`; no `light.mode` side files exist) |
| `foreground` | **dark** ink on paper | `#32161C` |
| `bright_foreground` | == `foreground` | `#32161C` (identical) |
| `light_foreground` | slightly lighter secondary text | `#4B2B31` |
| `dark_foreground` | low-contrast gray for chrome only | `#8A6A71` |
| `dark_background` / `darker_background` | surfaces recede to *darker* tones | `#F0E5E8` / `#E7D9DC` |
| `lighter_background`| sits between `background` and `dark_background` | `#F3E9EC` |
| ANSI `bright_*` | same value as the base color or a slightly stronger sibling | slightly lightened siblings |
| `accent` | one saturated accent, pulled **darker** than its dark-theme twin because it sits on paper | `#B62A3E` (dark twin uses `#E63950`) |

Official light themes do **not** hold ANSI to ≥ 4.5:1 (catppuccin-latte's
green is ~2.8:1). Crimson Light tightens this: every base ANSI color is
≥ 4.5:1; only its `bright_*` siblings and `dark_foreground` sit in the
3.8–4.4:1 chrome band, comparable to the official themes' weakest entries.

## 2. Measured contrast (WCAG formula, same calculator as `omarchy-theme-preview`)

Against `background #F9F2F4` (L = 0.905):

| Role | Key | Hex | Ratio |
|---|---|---|---|
| main text | `foreground`/`bright_foreground` | `#32161C` | **14.06:1** |
| secondary text | `light_foreground` | `#4B2B31` | **10.10:1** |
| chrome text | `dark_foreground` | `#8A6A71` | 3.97:1 |
| accent / red | `accent`/`red` | `#B62A3E` | **5.29:1** |
| `bright_red` | | `#C53344` | 4.57:1 |
| `yellow` / `bright_yellow` | | `#86600B` / `#876108` | 4.69:1 / 4.63:1 |
| `orange` | | `#A8491F` | 4.82:1 |
| `green` / `bright_green` | | `#2A7033` / `#2E7336` | 4.99:1 / 4.78:1 |
| `cyan` / `bright_cyan` | | `#0D6E75` / `#0F6E75` | 4.97:1 / 4.96:1 |
| `blue` / `bright_blue` | | `#24578D` / `#2E68A5` | 6.08:1 / 4.77:1 |
| `magenta` / (`purple`) | | `#A63E96` | 4.70:1 |
| `bright_magenta` | | `#B44FA6` | 3.84:1 |
| `brown` | | `#6B3D2A` | 7.32:1 |

Swap-check: `foreground #32161C` on `selection #EFDADE` keeps ~7.5:1;
`background` on `dark_background` offers an 8.5:1 invert pair.

## 3. Resolution check

`omarchy-theme-color --file colors.toml --all` resolves **58 keys**
(dark themes resolve 71 — the four original `*-mix`-style light/dark
preview variants and a few dark-only derivatives are the difference;
none are referenced by the built-in templates). Verified present and
correct: `mode = light`, `theme_type = light`, `bg`/`fg` aliases,
`color0–15`, `purple` → `#A63E96`, both
`hyprland_*_border` gradient strings intact.

Zero unexpanded `{{ }}` placeholders in staged `~/.local/state/omarchy/current/theme/`
after `omarchy theme install` (checked across all regenerated configs).

## 4. Staging (git theme)

`omarchy theme install` clones the repo and stages it; the deny list
(`*.lua`, `alacritty.toml`, `foot.ini`, `ghostty.conf`, `kitty.conf`,
`vscode.json`, symlinks) reported **nothing ignored** for this tree.
README/RESEARCH/LICENSE are staged as docs, as with the dark sibling.
`omarchy theme refresh` is idempotent (byte-identical staging) and does
not change the active background.

`preview.png` is a real desktop screenshot (1800×1012) taken while this
theme was live: clean first workspace over
`001-crimson-light-minimal.png`, then the `omarchy dev theme-preview
crimson-light --no-osc` console in a themed terminal.

## 5. Plymouth / OWE specifics

- `omarchy-plymouth-set-by-theme crimson-light` works exactly as for the
  dark theme: it uses `unlock.png` plus this theme's
  `background`/`foreground` (light boot: crimson mark on paper).
  `omarchy plymouth preview` composites `preview-unlock.png` and always
  ends "hanging" in `imv` — that is the viewer, not the pipeline; the PNG
  is already written (run under `timeout`).
- No `backgrounds/intros/`: animated intro media only benefits the
  optional OWE wallpaper engine and are intentionally not shipped.

## 6. Assets

- The three wallpapers are the light twins of the dark trio's motifs
  (paper flat + ring-and-dot; dawn gradient + hazy sun + ridges; pale
  bands + wine beziers), 2560×1440, 38–100 KB, authored for this theme.
- `unlock.png` reuses the dark sibling's crimson key art (1108×523,
  transparent) — it is legible on the light lock/boot surface too, which
  keeps the family identity identical.
- Icons `Yaru-red`, keyboard backlight `e63950` (the keyboard RGB has no
  light/dark distinction in Omarchy's pipeline).
