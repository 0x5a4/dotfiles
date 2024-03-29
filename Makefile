.ONESHELL:
.DEFAULT_GOAL:=targets

# used for generating the help
TARGET_LIST:=

# The directory where the Makefile actually lives
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# RCM setup
COMMON_FLAGS:=-v -d "$(ROOT_DIR)"
ifdef HOSTNAME
	COMMON_FLAGS+=-B "$(HOSTNAME)"
endif

COMMAND:=rcup $(COMMON_FLAGS)
# if set, run additional install steps
INSTALL:=yes

ifdef unmake
	UNMAKE:=1
endif

ifdef pretend
	PRETEND:=1
endif

ifdef UNMAKE
	undefine INSTALL
	COMMAND:=rcdn $(COMMON_FLAGS)
endif

ifdef PRETEND
	undefine INSTALL
	COMMAND:=lsrc $(COMMON_FLAGS)
endif

# groups
wayland: hyprland kitty mako rofi waybar swayidle wob scripts
shell: fish starship bash tmux nvim git btop
x11: picom rofi bspwm sxhkd scripts
	
# find my children
include $(shell find $(ROOT_DIR) -name *.inc)

define HELPMESSAGE
init     - link rcm config
scripts  - install .local/bin scripts
unmake   - remove all links

sets:
  shell    - install all files for a shell workflow
  wayland  - install all files for a wayland desktop
  x11      - install all files for a x11 desktop

configs:
endef

define HELPFOOTER
	
If you want to dry-run a target, run it with PRETEND=1
If you want to remove a specific target, run it with UNMAKE=1	
endef

export HELPMESSAGE
export HELPFOOTER

targets help:
	@echo "$$HELPMESSAGE"
	@echo "$(sort $(TARGET_LIST))" | tr ' ' '\n' | sed -e 's/^/  /' 
	@echo "$$HELPFOOTER"

unmake: init $(UNMAKE_HELPERS)
	rcdn $(COMMON_FLAGS)	
	@echo "NOTE: To properly clean up you still need to remove some files by hand"
	@echo "paths that possibly need cleaning:"
	@echo "  ~/.config/fish/plugins: $$(([ -d ~/.config/fish/plugins ] && echo exists) || echo doesnt exist)"
	@echo "  ~/.config/tmux/plugins: $$(([ -d ~/.config/tmux/plugins ] && echo exists) || echo doesnt exist)"
	@echo "  ~/.local/share/nvim/lazy: $$(([ -d ~/.local/share/nvim/lazy ] && echo exists) || echo doesnt exist)"
	@echo "  ~/.local/share/nvim/mason: $$(([ -d ~/.local/share/nvim/mason ] && echo exists) || echo doesnt exist)"

scripts: 
	$(COMMAND) local/bin

init: ~/.rcrc
~/.rcrc: 
	ln -s "$(ROOT_DIR)/rcrc" ~/.rcrc

.PHONY: robert
robert:
	cd $(ROOT_DIR) && git pull --rebase --autostash
