PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

all: zsh
zsh: setup link

link: setup
	@stow -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))

setup:
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@mkdir -p $(XDG_CACHE_HOME)/zsh

setup-plugins:
	@github-install --no-user sindresorhus/pure $(XDG_DATA_HOME)/pure
	@github-install --no-user zsh-users/zsh-autosuggestions $(XDG_DATA_HOME)/zsh-autosuggestions
	@github-install --no-user zsh-users/zsh-history-substring-search $(XDG_DATA_HOME)/zsh-history-substring-search
	@github-install --no-user zsh-users/zsh-syntax-highlighting $(XDG_DATA_HOME)/zsh-syntax-highlighting
