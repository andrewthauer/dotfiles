DOTFILES_DIR = $(CURDIR)/..
HAMMERSPOON_DIR = $(CURDIR)/.hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# SpoonInstall url
SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: defaults plugins

@macos: all

defaults:
	$(CURDIR)/settings/defaults.sh

hammerspoon:
	@mkdir -p "$(SPOONS_DIR)"
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(XDG_CONFIG_HOME)/hammerspoon/init.lua"

.PHONY: all defaults hammerspoon
