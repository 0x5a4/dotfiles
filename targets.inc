# vim:set filetype=make:
AUTO_FILES:=ideavimrc

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=bash zsh nixos

.PHONY: nixos $(AUTO_FILES)

bash: init
	$(COMMAND) bashrc bash_profile

zsh: init
	$(COMMAND) zshenv config/zsh

nixos:
ifdef INSTALL
	sudo nixos-rebuild --flake "$(ROOT_DIR)" switch
else
	@echo "nixos rebuild cant be dry-run/unmade"
endif

$(AUTO_FILES): init
	$(COMMAND) /$@
