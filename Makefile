# Package bundles
PKG_CORE = \
	bash git homebrew ssh vim zsh
PKG_OPT = \
	fasd docker dotnet gcloud golang gradle java kotlin kubernetes maven \
	node powershell python redis ruby rust scala sdkman tmux utility
PKG_LOCAL = @local
PKG_MAC = @macos
PKG_OPT_DEFAULT = docker fasd node python ruby tmux utility
PKG_ALL = $(PKG_CORE) $(PKG_OPT)

# Dotfiles directories
DOTFILES_DIR := $(CURDIR)
PKG_DIR = $(DOTFILES_DIR)
PKG_OPT_DIR = $(DOTFILES_DIR)/opt
LOCAL_DIR = $(DOTFILES_DIR)/$(PKG_LOCAL)

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Sub directories with makefiles
SUBDIRS = vim zsh

all: setup link $(SUBDIRS)

setup:
	@stow -t $(HOME) -d $(PKG_DIR) -S stow
	@mkdir -p $(LOCAL_DIR)
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_CACHE_HOME)/less

link: setup
	@stow -t $(HOME) -d $(PKG_DIR) -S $(PKG_CORE)
	@stow -t $(HOME) -d $(PKG_DIR) -S $(PKG_LOCAL)
	@stow -t $(HOME) -d $(PKG_OPT_DIR) -S $(PKG_OPT_DEFAULT)
ifeq ($(shell uname), Darwin)
	@stow -t $(HOME) -S $(PKG_MAC)
endif

unlink: setup
	# @stow -D -t $(HOME) -d $(PKG_DIR) -S $(PKG_ALL)

chklink: setup
	@echo "\n--- These are currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(PKG_DIR) $(PKG_ALL)
	@stow -n -v -t $(HOME) -d $(PKG_OPT_DIR) $(PKG_ALL)
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(HOME)/.ssh
	@chkstow -a -b -t $(HOME)/.

clean:
	@rm -f $(HOME)/.bashrc
	@rm -f $(HOME)/.bash_profile
	@rm -f $(HOME)/.hushlogin
	@rm -f $(HOME)/.zshenv
	@rm -rf $(HOME)/.ssh/config.d
	@rm -f $(HOME)/.stow-global-ignore
	@rm -rf $(XDG_CONFIG_HOME)/homebrew
	@rm -f $(XDG_CONFIG_HOME)/bash
	@rm -rf $(XDG_CONFIG_HOME)/git
	@rm -f $(XDG_CONFIG_HOME)/nvim
	@rm -f $(XDG_CONFIG_HOME)/profile.d/*
	@rm -f $(XDG_CONFIG_HOME)/tmux
	@rm -f $(XDG_CONFIG_HOME)/wgetrc
	@rm -f $(XDG_CONFIG_HOME)/zsh
	@rm -f $(XDG_BIN_HOME)/*

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
