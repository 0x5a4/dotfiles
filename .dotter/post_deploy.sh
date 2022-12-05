#!/bin/bash

# Tmux
{{#if dotter.packages.tmux}}
if [[ ! -d "${XDG_CONFIG_HOME}/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME}/tmux/plugins/tpm"
fi
{{/if}}
