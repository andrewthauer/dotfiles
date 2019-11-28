DOTFILES_DIR = $(CURDIR)/../..
LAUNCH_AGENTS = $(HOME)/Library/LaunchAgents

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# Hammerspoon
HAMMERSPOON_DIR = $(XDG_CONFIG_HOME)/hammerspoon
SPOONS_DIR = $(HAMMERSPOON_DIR)/Spoons
SPOON_INSTALL_URL = https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip

all: link setenv hammerspoon xdg

macos: all

link:
	@stow -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

setenv:
	@launchctl unload $(LAUNCH_AGENTS)/environment.plist
	@launchctl load $(LAUNCH_AGENTS)/environment.plist
ifneq ("$(wildcard $(LAUNCH_AGENTS)/environment-local.plist)", "")
	@launchctl unload $(LAUNCH_AGENTS)/environment-local.plist
	@launchctl load $(LAUNCH_AGENTS)/environment-local.plist
endif

hammerspoon:
	@mkdir -p "$(SPOONS_DIR)"
	@curl $(SPOON_INSTALL_URL) | tar -xz -C $(SPOONS_DIR)
	@defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(XDG_CONFIG_HOME)/hammerspoon/init.lua"

xdg:
	@defaults write com.kapeli.dashdoc "syncFolderPath" -string "$(XDG_CONFIG_HOME)"

defaults:
	@$(CURDIR)/_setup/defaults.sh
