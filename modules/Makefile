BIN_DIR = $(CURDIR)/../bin
ZFUNC_DIR = $(CURDIR)/../zfunc
REPOS_DIR = $(CURDIR)/../repos
export DOTFILES_REPOS_DIR := $(REPOS_DIR)

GITHUB_INSTALL = $(BIN_DIR)/github-install
SYMLINK = $(BIN_DIR)/symlink

MODULES = bash docker dotfiles git hammerspoon homebrew rust vim zsh

.PHONY: all
all: $(MODULES)

.PHONY: bash
bash:
	@$(SYMLINK) $(CURDIR)/bash/.bash_profile ~/.bash_profile
	@$(SYMLINK) $(CURDIR)/bash/.bashrc ~/.bashrc

.PHONY: docker
docker:
	@$(GITHUB_INSTALL) docker/cli
	@$(GITHUB_INSTALL) docker/compose
	@$(SYMLINK) $(REPOS_DIR)/docker/cli/contrib/completion/zsh/_docker $(ZFUNC_DIR)/_docker
	@$(SYMLINK) $(REPOS_DIR)/docker/compose/contrib/completion/zsh/_docker-compose $(ZFUNC_DIR)/_docker-compose

.PHONY: dotfiles
dotfiles:
	@$(MAKE) -C $(CURDIR)/dotfiles

.PHONY: git
git:
	@$(SYMLINK) $(CURDIR)/git/.gitignore_global ~/.gitignore
	@$(SYMLINK) $(CURDIR)/git/.gitconfig ~/.gitconfig

.PHONY: hammerspoon
hammerspoon:
	@$(SYMLINK) $(CURDIR)/hammerspoon ~/.hammerspoon

.PHONY: homebrew
homebrew:
	@$(SYMLINK) $(CURDIR)/homebrew/Brewfile ~/.Brewfile

.PHONY: rust
rust:
	@$(SYMLINK) $(CURDIR)/rust/completion/_rustup $(ZFUNC_DIR)/_rustup

.PHONY: vim
vim:
	@$(MAKE) -C $(CURDIR)/vim

.PHONY: zsh
zsh:
	@$(SYMLINK) $(CURDIR)/zsh/.zshenv ~/.zshenv
	@$(SYMLINK) $(CURDIR)/zsh/.zshrc ~/.zshrc
	# misc
	@$(GITHUB_INSTALL) zsh-users/zsh-history-substring-search
	@$(GITHUB_INSTALL) zsh-users/zsh-syntax-highlighting
	# completions
	@$(GITHUB_INSTALL) zsh-users/zsh-completions
	@$(GITHUB_INSTALL) lukechilds/zsh-better-npm-completion
	# prompt
	@$(GITHUB_INSTALL) sindresorhus/pure
	@$(SYMLINK) $(REPOS_DIR)/sindresorhus/pure/pure.zsh $(ZFUNC_DIR)/prompt_pure_setup
	@$(SYMLINK) $(REPOS_DIR)/sindresorhus/pure/async.zsh $(ZFUNC_DIR)/async

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
      $(MAKE) -C $$dir $(MAKECMDGOALS); \
    done
