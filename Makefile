# Package bundles
OPT_PKGS = $(sort $(notdir $(wildcard ./opt/*)))
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
LOCAL_OPT_PKGS = $(sort $(notdir $(wildcard ./local-opt/*)))
DEFAULT_OPT_PKGS = asdf
SYSTEM_PKG =

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# Sub directories with makefiles
SUBDIRS = etc opt/java

# macOS specific settings
ifeq ($(shell uname), Darwin)
	SYSTEM_PKG = macos
	SUBDIRS := $(SUBDIRS) system/$(SYSTEM_PKG)
	LAUNCH_AGENTS = $(HOME)/Library/LaunchAgents
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	SYSTEM_PKG = linux
	SUBDIRS := $(SUBDIRS) system/$(SYSTEM_PKG)
endif

all: setup link $(SUBDIRS)

check-scripts:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*' ! -name 'time-zsh')
	@shellcheck $$(find . -name '*.sh')

dummy:
	echo $(sort $(notdir $(wildcard ./opt*/*)))

setup:
	@mkdir -p $(CURDIR)/local
	@mkdir -p $(XDG_CONFIG_HOME)/{profile.d,shell.d}
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)
	@ln -sf .dotfiles/etc/.stow-global-ignore $(HOME)/.stow-global-ignore

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S etc local
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(DEFAULT_OPT_PKGS)
	@stow -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)
	# @stow -t $(HOME) -d $(CURDIR)/local-opt -S $(LOCAL_OPT_PKGS)

link-opt:
	# make link-opt pkg=github
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(pkg)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S etc local
	@stow -D -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@stow -D -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)
	# @stow -D -t $(HOME) -d $(CURDIR)/local-opt -S $(LOCAL_OPT_PKGS)

chklink:
	@echo "\n--- Files from 'etc' currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S etc
	@echo "\n--- System package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)
	@echo "\n--- Optional package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@echo "\n--- Local packages currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S local
	@stow -n -v -t $(HOME) -d $(CURDIR)/local-opt -S $(LOCAL_OPT_PKGS)
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(XDG_BIN_HOME)
	@chkstow -a -b -t $(XDG_LIB_HOME)
ifeq ($(shell uname), Darwin)
	@chkstow -a -b -t $(LAUNCH_AGENTS)
endif

clean:
	@rm -f $(HOME)/.bashrc
	@rm -f $(HOME)/.bash_profile
	@rm -f $(HOME)/.hushlogin
	@rm -f $(HOME)/.zsh*
	@rm -rf $(HOME)/.ssh/config.d
	@rm -f $(HOME)/.stowrc
	@rm -f $(HOME)/.stow-global-ignore
	@rm -f $(XDG_CONFIG_HOME)/asdf/*
	@rm -f $(XDG_CONFIG_HOME)/bash
	@rm -f $(XDG_CONFIG_HOME)/gem
	@rm -f $(XDG_CONFIG_HOME)/git/*
	@rm -f $(XDG_CONFIG_HOME)/hammerspoon
	@rm -f $(XDG_CONFIG_HOME)/homebrew/*
	@rm -f $(XDG_CONFIG_HOME)/karabiner
	@rm -f $(XDG_CONFIG_HOME)/maven/*
	@rm -f $(XDG_CONFIG_HOME)/nvim
	@rm -f $(XDG_CONFIG_HOME)/profile
	@rm -f $(XDG_CONFIG_HOME)/profile.d/*
	@rm -f $(XDG_CONFIG_HOME)/python
	@rm -f $(XDG_CONFIG_HOME)/shell.d/*
	@rm -f $(XDG_CONFIG_HOME)/tmux
	@rm -f $(XDG_CONFIG_HOME)/wgetrc
	@rm -f $(XDG_CONFIG_HOME)/zsh

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: .DEFAULT $(SUBDIRS)
