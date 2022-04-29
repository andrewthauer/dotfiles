PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

all: macos
macos: link

link:
	@stow -t $(HOME) -d $(PARENT_DIR) -S $(notdir $(CURDIR))

unlink:
	@stow -t $(HOME) -d $(PARENT_DIR) -D $(notdir $(CURDIR))

defaults: link
	@$(CURDIR)/_setup/defaults.sh
