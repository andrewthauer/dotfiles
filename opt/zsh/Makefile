DOTFILES_DIR = $(CURDIR)/../..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/bin/github-install

all: link zsh

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

zsh:
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@mkdir -p $(XDG_CACHE_HOME)/zsh

zsh-plugins:
	@github-install --no-user sindresorhus/pure $(XDG_DATA_HOME)/pure
	@github-install --no-user zsh-users/zsh-autosuggestions $(XDG_DATA_HOME)/zsh-autosuggestions
	@github-install --no-user zsh-users/zsh-history-substring-search $(XDG_DATA_HOME)/zsh-history-substring-search
	@github-install --no-user zsh-users/zsh-syntax-highlighting $(XDG_DATA_HOME)/zsh-syntax-highlighting
