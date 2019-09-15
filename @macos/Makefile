DOTFILES_DIR = $(CURDIR)/..
HAMMERSPOON_DIR = $(CURDIR)/.hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons

SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: setup plugins

vim: all

setup:
	@mkdir -p "$(SPOONS_DIR)"

plugins: setup
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)

.PHONY: all setup plugins
