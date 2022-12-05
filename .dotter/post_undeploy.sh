#!/bin/bash

# Remove leftover plugin files
{{#if dotter.packages.tmux}}
    rm -rf "${XDG_CONFIG_HOME}/tmux" 
{{/if}}

{{#if dotter.packages.tmux}}
    rm -rf "${XDG_DATA_HOME}/nvim" 
    rm -rf "${XDG_CONFIG_HOME}/nvim/plugin" 
{{/if}}
