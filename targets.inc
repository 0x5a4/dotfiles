# vim:set filetype=make:
AUTO_FILES:=ideavimrc

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=bash zsh nixos home-manager

.PHONY: nixos home-manager $(AUTO_FILES)

bash: init
	$(COMMAND) bashrc bash_profile

zsh: init
	$(COMMAND) zshenv config/zsh

nixos:
ifdef INSTALL
	sudo nixos-rebuild --flake "$(ROOT_DIR)/nixos" switch
else
	@echo "nixos rebuild cant be dry-run/unmade"
endif

home-manager:
ifdef INSTALL
	home-manager switch --flake "${ROOT_DIR}/home-manager"
else
	@echo "home-manager cant be dry-run/unmade"
endif

$(AUTO_FILES): init
	$(COMMAND) /$@
