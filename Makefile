DOTFILES_DIR = $(CURDIR)
DOTFILES_CMD = $(DOTFILES_DIR)/bin/dotfiles

# Package bundles
PKG_DIR = $(DOTFILES_DIR)/modules
ALL_PKGS = $(sort $(basename $(dir $(wildcard modules/*/))))
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
DEFAULT_PKGS = _stow _core fzf git gh local ssh starship utility vim zoxide zsh

# Subdirectories with make files
SUBDIRS = $(sort $(basename $(dir $(wildcard */Makefile))))
PKG_MAKEFILES = $(SUBDIRS:/=)

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# macOS specific settings
ifeq ($(shell uname), Darwin)
	DEFAULT_PKGS := $(DEFAULT_PKGS) macos homebrew hammerspoon karabiner
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	DEFAULT_PKGS := $(DEFAULT_PKGS)
endif

default: install

# Refactor to use dotfiles module link
.PHONY: install
install: link

.PHONY: lint
lint: shellcheck shfmt

# TODO: Remove when refactored to use dotfiles module command
.PHONY: link
link: prepare-dirs
	@stow -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)

# TODO: Remove when refactored to use dotfiles module command
.PHONY: unlink
unlink:
	@stow -t $(HOME) -d $(PKG_DIR) -D $(ALL_PKGS)

.PHONY: prepare-dirs
prepare-dirs:
	@mkdir -p $(DOTFILES_DIR)
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_CACHE_HOME)/less
	@mkdir -p $(XDG_BIN_HOME)

.PHONY: shellcheck
shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shellcheck $$(find . -name '*.sh')

.PHONY: shfmt
shfmt:
	@shfmt -i 2 -ci -l $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -i 2 -ci -l $$(find . -name '*.sh')

.PHONY: .chklink
chklink:
	@echo "\n--- Default package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)
	@echo "\n--- Bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(XDG_BIN_HOME)
	@chkstow -a -b -t $(XDG_LIB_HOME)

.PHONY: list-pkgs
list-pkgs:
	@echo $(ALL_PKGS:/=)

.PHONY: list-makefiles
list-makefiles:
	@echo $(PKG_MAKEFILES)

.PHONY: $(PKG_MAKEFILES)
$(PKG_MAKEFILES):
	@echo $@
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: .DEFAULT
.DEFAULT:
	@for dir in $(PKG_MAKEFILES); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done
