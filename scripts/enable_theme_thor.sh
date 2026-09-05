#!/bin/bash

THEME_PATH=""
if [ -d "/roms/themes/dii-ess-aye" ]; then
    THEME_PATH="/roms/themes/dii-ess-aye"
elif [ -d "/roms/themes/dii-ess-aye-main" ]; then
    THEME_PATH="/roms/themes/dii-ess-aye-main"
elif [ -d "/storage/.config/emulationstation/themes/dii-ess-aye" ]; then
    THEME_PATH="/storage/.config/emulationstation/themes/dii-ess-aye"
elif [ -d "/storage/.config/emulationstation/themes/dii-ess-aye-main" ]; then
    THEME_PATH="/storage/.config/emulationstation/themes/dii-ess-aye-main"
else
    echo "ERROR! Couldn't find a dii-ess-aye theme folder on your device!"
    exit 1
fi

chmod +x "${THEME_PATH}/scripts/start_es_thor.sh"
mount --bind "${THEME_PATH}/scripts/start_es_thor.sh" "/usr/bin/start_es.sh"

cat <<EOF >/storage/.config/sway/config
seat * hide_cursor 1000
default_border none
exec_always mako
# Present the real panels as one 3160x1080 logical desktop.  DSI-2 is
# the upper panel and DSI-1 is the lower panel on the AYN Thor.
output DSI-2 transform 90
output DSI-2 position 0 0
output DSI-2 bg #000000 solid_color
output DSI-2 allow_tearing yes
output DSI-2 max_render_time off
output DSI-1 transform 90
output DSI-1 position 1920 0
output DSI-1 bg #000000 solid_color
output DSI-1 power on
output DSI-1 allow_tearing yes
output DSI-1 max_render_time off
for_window [title=".*(Secondary|\[w2\]|Sub|Bottom|Screen 2|GamePad).*"] move window to output DSI-1
for_window [title=".*(Secondary|\[w2\]|Sub|Bottom|Screen 2|GamePad).*"] seat seat0 attach "*"
for_window [title="RetroArch\s(melonDS|DeSmuME|VecX|MAME|FinalBurn|FB Alpha).*"] exec /usr/bin/vertical-check
# The ES surface uses the same 3160x1080 geometry as the tiled outputs.
for_window [app_id="emulationstation"] floating enable
for_window [app_id="emulationstation"] fullscreen disable
for_window [app_id="emulationstation"] move absolute position 0 0
for_window [app_id="emulationstation"] focus
EOF

swaymsg reload

ES_SETTINGS="/storage/.config/emulationstation/es_settings.cfg"
if grep -q '<string name="FullScreenMenu"' "$ES_SETTINGS" 2>/dev/null; then
    sed -i 's|<string name="FullScreenMenu" value="[^"]*" />|<string name="FullScreenMenu" value="false" />|' "$ES_SETTINGS"
else
    sed -i 's|</config>|\t<string name="FullScreenMenu" value="false" />\n</config>|' "$ES_SETTINGS"
fi

if grep -q '<string name="GameTransitionStyle"' "$ES_SETTINGS" 2>/dev/null; then
    sed -i 's|<string name="GameTransitionStyle" value="[^"]*" />|<string name="GameTransitionStyle" value="fade" />|' "$ES_SETTINGS"
else
    sed -i 's|</config>|\t<string name="GameTransitionStyle" value="fade" />\n</config>|' "$ES_SETTINGS"
fi

if grep -q '<string name="ThemeSet"' "$ES_SETTINGS" 2>/dev/null; then
    sed -i 's|<string name="ThemeSet" value="[^"]*" />|<string name="ThemeSet" value="dii-ess-aye" />|' "$ES_SETTINGS"
else
    sed -i 's|</config>|\t<string name="ThemeSet" value="dii-ess-aye" />\n</config>|' "$ES_SETTINGS"
fi

if [ ! -f "/tmp/has-restarted-for-theme" ]; then
    touch /tmp/has-restarted-for-theme
    systemctl restart essway
fi
