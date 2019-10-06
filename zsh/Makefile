DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin

GITHUB_INSTALL = $(BIN_DIR)/github-install

all: setup link plugins

zsh: all

setup:
	@mkdir -p $(XDG_CONFIG_HOME)/zsh
	@mkdir -p $(XDG_DATA_HOME)/zsh
	@mkdir -p $(XDG_CACHE_HOME)/zsh

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S zsh

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S zsh

plugins: setup
	@$(GITHUB_INSTALL) -n sindresorhus/pure $(XDG_DATA_HOME)
