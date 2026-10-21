#!/bin/bash
# Generate the Lula Light lock artwork from the theme palette.
#
#   ./scripts/make-unlock.sh [theme-dir] [unlock.png] [preview-unlock.png]
#
# The mark is the Lula family monogram - circle, square and diamond - built
# from primitives so it can be re-tuned without a design tool. The two
# interlock zones (circle/square and square/diamond) are painted a step
# deeper so the overlap reads on paper, and the whole mark sits on a soft
# warm shadow instead of the dark sibling's red glow.
set -euo pipefail

theme_dir=${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}
out_unlock=${2:-$theme_dir/unlock.png}
out_preview=${3:-$theme_dir/preview-unlock.png}

W=1108
H=523

color() { omarchy-theme-color "$1" --file "$theme_dir/colors.toml"; }

accent=$(color accent)
background=$(color background)
foreground=$(color foreground)
muted=$(color muted)

# shade <base hex> <fill colour> <colorize percent> -> hex
shade() {
  local rgb
  rgb=$(magick -size 1x1 "xc:$1" -fill "$2" -colorize "$3" \
    -format '%[fx:round(r*255)] %[fx:round(g*255)] %[fx:round(b*255)]' info:)
  printf '#%02X%02X%02X' $rgb
}

# A deeper sibling of the accent for the interlock zones.
deeper=$(shade "$accent" black 24%)
# Warm shadow ink: the accent pulled toward the muted tone.
shadow=$(shade "$accent" "$muted" 55%)

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# --- geometry ------------------------------------------------------------
CIRCLE="circle 260,260 466,260"
SQUARE="rectangle 392,70 742,451"
DIAMOND="polygon 845,55 1045,255 845,455 645,255"

mask() { # $1 = draw primitive, $2 = output path (grayscale: black = off)
  magick -size ${W}x${H} xc:black -fill white -draw "$1" -colorspace gray "$2"
}

tint() { # $1 = grayscale mask, $2 = colour, $3 = output path
  magick -size ${W}x${H} "xc:$2" "$1" -alpha off \
    -compose CopyOpacity -composite "$3"
}

mask "$CIRCLE" "$tmp/circle.png"
mask "$SQUARE" "$tmp/square.png"
mask "$DIAMOND" "$tmp/diamond.png"

# Union of the three shapes, used for the shadow.
magick "$tmp/circle.png" "$tmp/square.png" "$tmp/diamond.png" \
  -compose Lighten -composite "$tmp/union.png"

# Pairwise intersections: the two interlock zones.
magick "$tmp/circle.png" "$tmp/square.png" -compose Multiply -composite "$tmp/cr.png"
magick "$tmp/square.png" "$tmp/diamond.png" -compose Multiply -composite "$tmp/rd.png"

# --- the mark ------------------------------------------------------------
# Solid shapes in the accent.
magick -size ${W}x${H} xc:none \
  -fill "$accent" \
  -draw "$CIRCLE" -draw "$SQUARE" -draw "$DIAMOND" \
  "$tmp/mark-base.png"

# Interlock zones one step deeper.
tint "$tmp/cr.png" "$deeper" "$tmp/cr-color.png"
tint "$tmp/rd.png" "$deeper" "$tmp/rd-color.png"
magick "$tmp/mark-base.png" "$tmp/cr-color.png" -compose Over -composite "$tmp/step1.png"
magick "$tmp/step1.png" "$tmp/rd-color.png" -compose Over -composite "$tmp/mark.png"

# Soft warm shadow underneath, so the mark sits on paper instead of glowing.
magick "$tmp/union.png" -blur 0x16 -evaluate multiply 0.5 "$tmp/shadow-mask.png"
magick "$tmp/shadow-mask.png" -roll +0+10 "$tmp/shadow-mask.png"
tint "$tmp/shadow-mask.png" "$shadow" "$tmp/shadow.png"

magick "$tmp/shadow.png" "$tmp/mark.png" -compose Over -composite \
  -depth 8 -strip "$out_unlock"

# --- lock screen preview -------------------------------------------------
# Same mark, centred on the theme's paper, with the lock field below it.
PW=1920
PH=1080

magick -size ${PW}x${PH} "xc:$background" "$out_unlock" \
  -gravity north -geometry +0+310 -compose Over -composite \
  "$tmp/preview-mark.png"

# Password field: outline plus four dots, in the foreground ink.
FIELD_X=818
FIELD_Y=843
FIELD_W=284
FIELD_H=42

magick -size ${PW}x${PH} xc:none \
  -fill none -stroke "$foreground" -strokewidth 2 \
  -draw "rectangle $FIELD_X,$FIELD_Y $((FIELD_X + FIELD_W)),$((FIELD_Y + FIELD_H))" \
  -fill "$foreground" -stroke none \
  -draw "circle 843,862 848,862" \
  -draw "circle 858,862 863,862" \
  -draw "circle 873,862 878,862" \
  -draw "circle 888,862 893,862" \
  "$tmp/field.png"

# Lock glyph: shackle plus body.
magick -size ${PW}x${PH} xc:none \
  -fill none -stroke "$foreground" -strokewidth 7 \
  -draw "arc 777,846 800,869 180,360" \
  -fill "$foreground" -stroke none \
  -draw "roundrectangle 772,862 803,881 4,4" \
  -draw "circle 787,871 792,871" \
  "$tmp/lock.png"

magick "$tmp/preview-mark.png" "$tmp/lock.png" -compose Over -composite "$tmp/step-lock.png"
magick "$tmp/step-lock.png" "$tmp/field.png" -compose Over -composite \
  -depth 8 -strip "$out_preview"

echo "wrote $out_unlock"
echo "wrote $out_preview"
