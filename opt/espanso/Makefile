PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config

# Espanso config directory
ESPANSO_CONFIG_DIR := $(XDG_CONFIG_HOME)/espanso

# macOS specific
MACOS_PREFERENCES_DIR = $(HOME)/Library/Preferences
MACOS_ESPANSO_CONFIG_DIR = $(MACOS_PREFERENCES_DIR)/espanso

all: espanso
espanso: setup link

setup:
	@mkdir -p $(ESPANSO_CONFIG_DIR)
	@mkdir -p $(ESPANSO_CONFIG_DIR)/user

link: setup
	@stow -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))
ifeq ($(shell uname), Darwin)
	@ln -fs $(ESPANSO_CONFIG_DIR) $(MACOS_ESPANSO_CONFIG_DIR)
endif

unlink:
	@stow -D -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))
ifeq ($(shell uname), Darwin)
	@rm $(MACOS_ESPANSO_CONFIG_DIR)
endif
