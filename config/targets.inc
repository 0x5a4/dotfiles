# vim:set filetype=make:
AUTO_FILES:=mako fish nvim kitty zathura rofi waybar swayidle bspwm sxhkd

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=starship tmux hyprland picom git

starship: init
	$(COMMAND) config/starship.toml

TMUX_PLUGINS:=$(XDG_CONFIG_HOME)/tmux/plugins
tmux: init
	$(COMMAND) config/tmux
	[ -d "$(TMUX_PLUGINS)/tpm" ] || git clone "https://github.com/tmux-plugins/tpm" "$(TMUX_PLUGINS)/tpm"

hyprland: init
	$(COMMAND) config/hypr

picom: init
	$(COMMAND) config/picom.conf

git: init
	$(COMMAND) gitconfig gitignore

.PHONY: $(AUTO_FILES)
$(AUTO_FILES): init
	$(COMMAND) config/$@
