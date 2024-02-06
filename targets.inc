# vim:set filetype=make:
AUTO_FILES:=ideavimrc

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=bash zsh nixos

.PHONY: nixos $(AUTO_FILES)

bash: init
	$(COMMAND) bashrc bash_profile

zsh: init
	$(COMMAND) zshenv config/zsh


ifdef INSTALL
nixos:
	sudo nixos-rebuild --flake "$(ROOT_DIR)" test

nixactivate:
	sudo nixos-rebuild --flake "${ROOT_DIR}" switch

nixboot:
	sudo nixos-rebuild boot --install-bootloader --flake .
	
else
	
ifdef PRETEND
# pretend installation(same for every target)
nixos nixcommit nixboot:
	nixos-rebuild --flake "${ROOT_DIR}" dry-activate
	
else
# unmaking is impossible ¯\_(ツ)_/¯
nixos nixcommit nixboot:
	@echo "cant unmake nixos"
	
endif
endif

$(AUTO_FILES): init
	$(COMMAND) /$@
