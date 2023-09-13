.ONESHELL:
ifndef VERBOSE
.SILENT:
endif

# list of files that should have their target auto generated
AUTO_FILES=ideavimrc
# list of files living inside config that should have their target auto generated
AUTO_CONFIG_FILES=mako fish nvim kitty zathura rofi waybar swayidle
# list of everything else. only used for the help
OTHERFILES=bash starship tmux hyprland picom git zsh

# The directory where the Makefile actually lives
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

COMMON_FLAGS=-v -d "$(ROOT_DIR)"
ifdef HOSTNAME
	COMMON_FLAGS+=-B "$(HOSTNAME)"
endif

COMMAND=rcup $(COMMON_FLAGS)

ifdef UNMAKE
	COMMAND=rcdn $(COMMON_FLAGS)
endif

ifdef PRETEND
	COMMAND=lsrc $(COMMON_FLAGS)
endif

define HELPMESSAGE
management-targets:
  init     - link rcm config
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

ALLCONFIGS=$(AUTO_FILES) $(AUTO_CONFIG_FILES) $(OTHERFILES)
targets:
	echo "$$HELPMESSAGE"
	echo "$(sort $(ALLCONFIGS))" | tr ' ' '\n' | sed -e 's/^/  /' 
	echo "$$HELPFOOTER"

# groups
wayland: hyprland kitty mako rofi waybar swayidle
shell: fish starship bash tmux nvim git
x11: bspwm sxhkd kitty picom rofi
	
# targets that need some sort of special treatment, e.g. <target-name> != <file-name>
# DONT FORGET TO CHANGE $OTHERFILES!
bash: init
	$(COMMAND) bashrc

starship: init
	$(COMMAND) config/starship.toml

TPM_LOCATION="$(XDG_CONFIG_HOME)/tmux/plugins/tpm"
tmux: init
	$(COMMAND) config/tmux
	[ -d "$(TPM_LOCATION)" ] || git clone "https://github.com/tmux-plugins/tpm" "$(TPM_LOCATION)"

hyprland: init
	$(COMMAND) config/hypr

picom: init
	$(COMMAND) config/picom.conf

git: init
	$(COMMAND) gitconfig gitignore

zsh: init
	$(COMMAND) zshenv config/zsh

# management targets
unmake: init
	rcdn $(COMMON_FLAGS)	
	rm ~/.rcrc

init: ~/.rcrc
~/.rcrc: 
	ln -s "$(ROOT_DIR)/rcrc" ~/.rcrc

.PHONY: $(AUTO_CONFIG_FILES)
$(AUTO_CONFIG_FILES): init
	$(COMMAND) config/$@

.PHONY: $(AUTO_FILES)
$(AUTO_FILES): init
	$(COMMAND) config/$@
