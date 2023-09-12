#!/bin/bash

CONFIG_FILES="$HOME/.config/mako/config"

while true; do
    makoctl reload
    inotifywait -e create,modify $CONFIG_FILES
done
