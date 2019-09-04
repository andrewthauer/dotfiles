DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin
REPOS_DIR = $(DOTFILES_DIR)/repos
PACK_START_DIR = $(CURDIR)/.vim/pack/default/start

GITHUB_INSTALL = $(BIN_DIR)/github-install
SYMLINK = $(BIN_DIR)/symlink
YARN := $(shell command -v yarn 2> /dev/null)

all: setup link update

setup:
	mkdir -p "$(CURDIR)/.vim/pack"
	mkdir -p "$(CURDIR)/.vim/pack/default"
	mkdir -p "$(CURDIR)/.vim/pack/default/opt"
	mkdir -p "$(CURDIR)/.vim/pack/default/start"

# link:
# 	@$(SYMLINK) $(CURDIR) ~/.vim
# 	@$(SYMLINK) $(CURDIR) ~/.config/nvim
# 	@$(SYMLINK) $(CURDIR)/.vimrc ~/.vimrc
# 	@$(SYMLINK) $(CURDIR)/.vimrc ~/.config/nvim/init.vim
# 	@$(SYMLINK) /usr/local/bin/nvim /usr/local/bin/vi

update:
	@$(GITHUB_INSTALL) editorconfig/editorconfig-vim $(REPOS_DIR)
	@$(SYMLINK) $(REPOS_DIR)/editorconfig/editorconfig-vim $(PACK_START_DIR)/editorconfig-vim
	@$(GITHUB_INSTALL) vim-scripts/Zenburn $(REPOS_DIR)
	@$(SYMLINK) $(REPOS_DIR)/vim-scripts/Zenburn $(PACK_START_DIR)/Zenburn
	@$(GITHUB_INSTALL) sheerun/vim-polyglot $(REPOS_DIR)
	@$(SYMLINK) $(REPOS_DIR)/sheerun/vim-polyglot $(PACK_START_DIR)/vim-polyglot
	@$(GITHUB_INSTALL) junegunn/fzf $(REPOS_DIR)
	@$(SYMLINK) $(REPOS_DIR)/junegunn/fzf $(PACK_START_DIR)/fzf
ifdef YARN
	@$(GITHUB_INSTALL) neoclide/coc.nvim $(REPOS_DIR) --post-install "yarn install --frozen-lockfile"
	@$(SYMLINK) $(REPOS_DIR)/neoclide/coc.nvim $(PACK_START_DIR)/coc.nvim
else
	@echo yarn not found
endif

.PHONY: all link update
