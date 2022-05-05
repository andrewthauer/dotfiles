# Package bundles
PKG_DIR = $(CURDIR)/modules
ALL_PKGS = $(sort $(basename $(dir $(wildcard modules/*/))))
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
DEFAULT_PKGS = asdf fasd fzf git github shell ssh starship utility vim zsh

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
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

# Subdirectories with make files
SUBDIRS = $(sort $(basename $(dir $(wildcard */Makefile))))
PKG_MAKEFILES = $(SUBDIRS:/=)

all: setup prepare-dirs link

shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*' ! -name 'time-zsh')
	@shellcheck $$(find . -name '*.sh')

check-shfmt:
	@shfmt -i 2 -ci -l $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -i 2 -ci -l $$(find . -name '*.sh')

lint: shellcheck check-shfmt

setup:
	@stow -t $(HOME) -d . -S etc

prepare-dirs:
	@mkdir -p $(CURDIR)/local
	@mkdir -p $(HOME)/.ssh/config.d
	@mkdir -p $(XDG_CONFIG_HOME)/profile.d
	@mkdir -p $(XDG_CONFIG_HOME)/shell.d
	@mkdir -p $(XDG_CONFIG_HOME)/git
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_DATA_HOME)/zsh
	@mkdir -p $(XDG_CACHE_HOME)/less
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)
ifeq ($(shell uname), Darwin)
	@mkdir -p $(XDG_CONFIG_HOME)/hammerspoon
	@mkdir -p $(XDG_CONFIG_HOME)/homebrew
endif

link: prepare-dirs setup
	@stow -t $(HOME) -d $(CURDIR) -S local
	@stow -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)

unlink:
	@stow -t $(HOME) -D local
	@stow -t $(HOME) -d $(PKG_DIR) -D $(filter-out stow,$(ALL_PKGS))

.PHONY: .chklink
chklink:
	@echo "\n--- Default package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)
	@echo "\n--- Local packages currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S local
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
