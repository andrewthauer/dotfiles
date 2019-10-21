# Package bundles
PKG_ALL = \
	aws bash fasd docker dotnet gcloud git golang gradle homebrew java \
	kotlin kubernetes maven node python redis ruby rust scala sdkman \
	shell ssh tmux vim zsh
PKG_LOCAL = @local
PKG_MACOS = @macos
PKG_LINUX = @linux

# Default packages
DEFAULT_PKGS = bash git shell ssh tmux vim zsh
DEFAULT_MACOS_PKGS = $(DEFAULT_PKGS) $(PKG_MACOS) $(PKG_LOCAL) \
	docker fasd homebrew node python ruby
DEFAULT_LINUX_PKGS = $(DEFAULT_PKGS) $(PKG_LINUX) $(PKG_LOCAL)

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Sub directories with makefiles
SUBDIRS = vim zsh

# macOS specific settings
ifeq ($(shell uname), Darwin)
	DEFAULT_PKGS := $(DEFAULT_PKGS) $(DEFAULT_MACOS_PKGS)
	SUBDIRS := $(SUBDIRS) $(PKG_MACOS)
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	DEFAULT_PKGS := $(DEFAULT_PKGS) $(DEFAULT_MACOS_PKGS)
	SUBDIRS := $(SUBDIRS) $(PKG_LINUX)
endif

all: setup link $(SUBDIRS)

setup:
	@stow -t $(HOME) -d $(CURDIR) -S stow
	@mkdir -p $(CURDIR)/$(PKG_LOCAL)
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_CACHE_HOME)/less

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S $(DEFAULT_PKGS)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S $(PKG_ALL)

chklink: setup
	@echo "\n--- These are currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) $(PKG_ALL)
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(HOME)/.ssh

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

.PHONY: .DEFAULT $(SUBDIRS)
