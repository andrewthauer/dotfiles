DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/opt/git/.local/bin/github-install

all: setup link vim zsh cheat

etc: all

setup:
	@mkdir -p $(HOME)/.ssh/config.d
	@mkdir -p $(XDG_CONFIG_HOME)/git
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_CACHE_HOME)/less
ifeq ($(shell uname), Darwin)
	@mkdir -p $(XDG_CONFIG_HOME)/homebrew
endif

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

vim:
	@$(DOTFILES_DIR)/etc/.config/nvim/setup.sh

zsh:
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@mkdir -p $(XDG_CACHE_HOME)/zsh
	@$(GITHUB_INSTALL) -n sindresorhus/pure $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-syntax-highlighting $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-history-substring-search $(XDG_DATA_HOME)
	@$(GITHUB_INSTALL) -n zsh-users/zsh-autosuggestions $(XDG_DATA_HOME)

cheat:
	@curl https://cheat.sh/:cht.sh > $(XDG_BIN_HOME)/cht.sh | chmod +x $(XDG_BIN_HOME)/cht.sh
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@curl https://cheat.sh/:zsh > $(XDG_DATA_HOME)/zsh/functions/_cht
