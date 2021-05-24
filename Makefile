# Package bundles
PKG_DIR = $(CURDIR)/opt
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
DEFAULT_PKGS = asdf fasd fzf git shell stow tmux vim

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# macOS specific settings
ifeq ($(shell uname), Darwin)
	DEFAULT_PKGS := $(DEFAULT_PKGS) macos homebrew
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	DEFAULT_PKGS := $(DEFAULT_PKGS) linux
endif

# Subdirectories with make files
SUBDIRS = $(sort $(basename $(dir $(wildcard opt/**/Makefile))))

all: setup link

shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*' ! -name 'time-zsh')
	@shellcheck $$(find . -name '*.sh')

check-shfmt:
	@shfmt -i 2 -ci -l $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -i 2 -ci -l $$(find . -name '*.sh')

lint: shellcheck check-shfmt

setup: setup-dirs
	@stow -t $(HOME) -d $(PKG_DIR) -S stow

setup-dirs:
	@mkdir -p $(CURDIR)/local
	@mkdir -p $(XDG_CONFIG_HOME)/{profile.d,shell.d}
	@mkdir -p $(XDG_CONFIG_HOME)/{git,less,openvpn,hammerspoon}
	@mkdir -p $(HOME)/.ssh/config.d
	@mkdir -p $(XDG_CACHE_HOME)/less
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)
ifeq ($(shell uname), Darwin)
	@mkdir -p $(XDG_CONFIG_HOME)/homebrew
endif

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S local
	@stow -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S etc local
	@stow -D -t $(HOME) -d $(PKG_DIR) -S $(DEFAULT_PKGS)

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

.PHONY: print-makes
print-makes:
	@echo $(SUBDIRS)

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@echo $@
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: .DEFAULT
.DEFAULT:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done
