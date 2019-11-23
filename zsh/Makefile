DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/git/.local/bin/github-install

all: setup link plugins

zsh: all

setup:
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@mkdir -p $(XDG_CACHE_HOME)/zsh

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

plugins: setup
	@$(GITHUB_INSTALL) -n sindresorhus/pure $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-syntax-highlighting $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-history-substring-search $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-autosuggestions $(XDG_DATA_HOME)
