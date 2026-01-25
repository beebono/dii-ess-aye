#!/bin/bash

ROMS_ROOT="/roms"

for dir in "$ROMS_ROOT"/*/; do
    gamelist="$dir/gamelist.xml"
    if [[ ! -f "$gamelist" ]]; then
        continue
    fi

    echo "Processing: $gamelist"
    grep -oP '(?<=<thumbnail>)[^<]+' "$gamelist" | while read -r thumbnail; do
        if [[ "$thumbnail" == ./* ]]; then
            thumbnail_path="$dir${thumbnail:2}"
        else
            thumbnail_path="$thumbnail"
        fi

        if [[ -f "$thumbnail_path" ]]; then
            echo "  Squishing: $thumbnail_path"
            mogrify -background darkgray -gravity center -resize 256x256^ "$thumbnail_path"
        else
            echo "  Warning: File not found: $thumbnail_path"
        fi
    done
done

echo "Done!"