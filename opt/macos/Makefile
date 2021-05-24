PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

all: macos
macos: link

link:
	@stow -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

defaults:
	@$(CURDIR)/_setup/defaults.sh
