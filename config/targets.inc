# vim:set filetype=make:
AUTO_FILES:=mako nvim kitty zathura rofi waybar swayidle bspwm sxhkd btop polybar

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=starship tmux hyprland picom git

starship: init
	$(COMMAND) config/starship.toml

TMUX_PLUGINS:=$(XDG_CONFIG_HOME)/tmux/plugins
tmux: init
	$(COMMAND) config/tmux
ifndef UNMAKE
	[ -d "$(TMUX_PLUGINS)/tpm" ] || git clone "https://github.com/tmux-plugins/tpm" "$(TMUX_PLUGINS)/tpm"
endif

fish: init
	$(COMMAND) config/fish
ifndef UNMAKE
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"
endif

hyprland: init
	$(COMMAND) config/hypr

picom: init
	$(COMMAND) config/picom.conf

git: init
	$(COMMAND) gitconfig gitignore

.PHONY: $(AUTO_FILES)
$(AUTO_FILES): init
	$(COMMAND) config/$@
