PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config

# Hammerspoon
HAMMERSPOON_DIR = $(XDG_CONFIG_HOME)/hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons
SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: hammerspoon
hammerspoon: link setup

link:
	@stow -t $(HOME) -d $(PARENT_DIR) -S $(notdir $(CURDIR))

unlink:
	@stow -t $(HOME) -d $(PARENT_DIR) -D $(notdir $(CURDIR))

setup:
	@mkdir -p "$(SPOONS_DIR)"
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)
	@defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(XDG_CONFIG_HOME)/hammerspoon/init.lua"
