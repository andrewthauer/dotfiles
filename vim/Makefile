DOTFILES_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# Vim pack directories
VIM_PACK_DIR = $(XDG_DATA_HOME)/nvim/site/pack
PACK_START_DIR = $(VIM_PACK_DIR)/default/start

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/git/.local/bin/github-install
HAS_YARN := $(shell command -v yarn 2> /dev/null)

all: setup link plugins

vim: all

setup:
	@mkdir -p "$(VIM_PACK_DIR)"
	@mkdir -p "$(VIM_PACK_DIR)/default"
	@mkdir -p "$(VIM_PACK_DIR)/default/opt"
	@mkdir -p "$(VIM_PACK_DIR)/default/start"
	@mkdir -p "$(HOME)/.config/nvim"
	@mkdir -p $(XDG_DATA_HOME)/vim/{undo,site,swap,backup}

link:
	@stow -d $(DOTFILES_DIR) -t ~ -S vim

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S vim

plugins: setup
	@$(GITHUB_INSTALL) -n editorconfig/editorconfig-vim $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n vim-scripts/Zenburn $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n sheerun/vim-polyglot $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n junegunn/fzf $(PACK_START_DIR)
ifdef HAS_YARN
	@$(GITHUB_INSTALL) -n neoclide/coc.nvim $(PACK_START_DIR) --post-install "yarn install --frozen-lockfile"
else
	@echo yarn not found
endif
