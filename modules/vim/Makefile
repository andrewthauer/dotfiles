BIN_DIR = $(CURDIR)/../../bin
REPOS_DIR = $(CURDIR)/../../repos
PACK_START_DIR = $(CURDIR)/pack/default/start

GITHUB_INSTALL = $(BIN_DIR)/github-install
SYMLINK = $(BIN_DIR)/symlink

all: link update

link:
	@$(SYMLINK) $(CURDIR) ~/.vim
	@$(SYMLINK) $(CURDIR) ~/.config/nvim
	@$(SYMLINK) $(CURDIR)/.vimrc ~/.vimrc
	@$(SYMLINK) $(CURDIR)/.vimrc ~/.config/nvim/init.vim
	@$(SYMLINK) /usr/local/bin/nvim /usr/local/bin/vi

update:
	@$(GITHUB_INSTALL) editorconfig/editorconfig-vim
	@$(SYMLINK) $(REPOS_DIR)/editorconfig/editorconfig-vim $(PACK_START_DIR)/editorconfig-vim
	@$(GITHUB_INSTALL) vim-scripts/Zenburn
	@$(SYMLINK) $(REPOS_DIR)/vim-scripts/Zenburn $(PACK_START_DIR)/Zenburn
	@$(GITHUB_INSTALL) sheerun/vim-polyglot
	@$(SYMLINK) $(REPOS_DIR)/sheerun/vim-polyglot $(PACK_START_DIR)/vim-polyglot
	@$(GITHUB_INSTALL) junegunn/fzf
	@$(SYMLINK) $(REPOS_DIR)/junegunn/fzf $(PACK_START_DIR)/fzf
	@$(GITHUB_INSTALL) neoclide/coc.nvim --post-install "yarn install --frozen-lockfile"
	@$(SYMLINK) $(REPOS_DIR)/neoclide/coc.nvim $(PACK_START_DIR)/coc.nvim

.PHONY: all link update
