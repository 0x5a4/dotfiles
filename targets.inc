# vim:set filetype=make:
AUTO_FILES:=ideavimrc

TARGET_LIST+=$(AUTO_FILES)
TARGET_LIST+=bash zsh

bash: init
	$(COMMAND) bashrc

zsh: init
	$(COMMAND) zshenv config/zsh

.PHONY: $(AUTO_FILES)
$(AUTO_FILES): init
	$(COMMAND) /$@
