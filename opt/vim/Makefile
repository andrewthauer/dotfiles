DOTFILES_DIR = $(CURDIR)/../..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/bin/github-install

all: link vim

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S $(notdir $(CURDIR))

vim:
	@sh -c 'curl -fLo $(XDG_DATA_HOME)/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
