PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# Hammerspoon
HAMMERSPOON_DIR = $(XDG_CONFIG_HOME)/hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons
SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: link hammerspoon

link:
	@stow -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

hammerspoon:
	@mkdir -p "$(SPOONS_DIR)"
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)
	@defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(XDG_CONFIG_HOME)/hammerspoon/init.lua"
