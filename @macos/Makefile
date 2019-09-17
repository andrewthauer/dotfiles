DOTFILES_DIR = $(CURDIR)/..
HAMMERSPOON_DIR = $(CURDIR)/.hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons

SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: defaults plugins

@macos: all

defaults:
	$(CURDIR)/settings/defaults.sh

plugins:
	@mkdir -p "$(SPOONS_DIR)"
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)

.PHONY: all defaults plugins
