DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

# Commands
GITHUB_INSTALL = $(DOTFILES_DIR)/opt/git/.local/bin/github-install

# Vim pack directories
VIM_PACK_DIR = $(XDG_DATA_HOME)/nvim/site/pack
PACK_START_DIR = $(VIM_PACK_DIR)/default/start

all: setup link vim zsh

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
	@mkdir -p "$(VIM_PACK_DIR)"
	@mkdir -p "$(VIM_PACK_DIR)/default"
	@mkdir -p "$(VIM_PACK_DIR)/default/opt"
	@mkdir -p "$(VIM_PACK_DIR)/default/start"
	@mkdir -p "$(HOME)/.config/nvim"
	@mkdir -p $(XDG_DATA_HOME)/vim/{undo,site,swap,backup}
	@ln -fs $(XDG_DATA_HOME)/nvim/site/pack $(XDG_CONFIG_HOME)/nvim/pack
	@$(GITHUB_INSTALL) -n editorconfig/editorconfig-vim $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n vim-scripts/Zenburn $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n sheerun/vim-polyglot $(PACK_START_DIR)
	@$(GITHUB_INSTALL) -n junegunn/fzf $(PACK_START_DIR)
ifdef HAS_YARN
	@$(GITHUB_INSTALL) -n neoclide/coc.nvim $(PACK_START_DIR) --post-install "yarn install --frozen-lockfile"
else
	@echo yarn not found
endif

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
