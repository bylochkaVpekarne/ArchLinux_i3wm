#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs"
CACHE_FILE="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE_DIR"
cd "$WALL_DIR" 2>/dev/null || exit 1

ROFI_INPUT=""

for img in *.{png,jpg,jpeg,PNG,JPG,JPEG}; do
    [ -f "$img" ] || continue
    
    thumb="$CACHE_DIR/$img"
    
    if [ ! -f "$thumb" ]; then
        (magick "$img" -thumbnail 200x200 "$thumb" 2>/dev/null || convert "$img" -thumbnail 200x200 "$thumb" 2>/dev/null) &
    fi
    
    ROFI_INPUT+="${img}\0icon\x1f${thumb}\n"
done

SELECTED=$(echo -e "$ROFI_INPUT" | rofi -dmenu -i -p "Choose wallpaper: " \
    -show-icons \
    -theme-str 'element-icon { size: 6ch; } listview { lines: 5; }')

if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALL_DIR/$SELECTED"
    feh --bg-fill "$FULL_PATH"
    echo "$FULL_PATH" > "$CACHE_FILE"
fi
