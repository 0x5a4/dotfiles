#!/usr/bin/env bash

GAME_CLASSES=(
    "steam_app_[0-9]*"
    "Stardew Valley"
    "Minecraft\*? 1.[0-9|.]*"
    "FTB Skies"
    "Enigmatica 2: Expert \- Extended"
    "hl_linux"
    "Nomifactory.*"
    "org.libretro.RetroArch"

)

if (( $# == 0 )); then
    echo "expected game workspace as parameter"
    exit
fi

GAME_WORKSPACE=$1

for class in "${GAME_CLASSES[@]}"; do
    hyprctl --batch "\
        keyword windowrule workspace ${GAME_WORKSPACE},^${class}\$;\
        keyword windowrule fullscreen,^$class\$; \
        keyword windowrule idleinhibit always,^$class\$; \
        keyword windowrule forcergbx,^$class\$; \
    "
done
