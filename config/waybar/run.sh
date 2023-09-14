#!/bin/bash

[ $(command -v inotifywait) ] || { exec waybar; exit;}

CONFIG_DIR="${XDG_CONFIG_HOME}/waybar"
CONFIG_FILES="${CONFIG_DIR}/config ${CONFIG_DIR}/shared-modules.json ${CONFIG_DIR}/style.css"

trap "killall waybar" EXIT

echo "Watching ${CONFIG_FILES}"

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
