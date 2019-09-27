DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin
VIM_PACK_DIR = $(CURDIR)/.vim/pack
PACK_START_DIR = $(VIM_PACK_DIR)/default/start

GITHUB_INSTALL = $(BIN_DIR)/github-install
HAS_YARN := $(shell command -v yarn 2> /dev/null)

all: setup link plugins

setup:
	@mkdir -p "$(VIM_PACK_DIR)"
	@mkdir -p "$(VIM_PACK_DIR)/default"
	@mkdir -p "$(VIM_PACK_DIR)/default/opt"
	@mkdir -p "$(VIM_PACK_DIR)/default/start"
	@mkdir -p "$(HOME)/.config/nvim"

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

vim: all
