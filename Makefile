# Package bundles
PKG_ROOT_ALL = bash git homebrew vim ssh tmux utility zsh
PKG_OPT_ALL = \
	aws docker dotnet fasd gcloud golang gradle java kotlin kubernetes maven \
	node powershell python redis ruby rust scala sdkman
PKG_SYS_LOCAL = @local
PKG_SYS_MAC = @macos
PKG_OPT_DEFAULT = fasd docker node python ruby
PKG_ROOT_DEFAULT = $(PKG_ROOT_ALL)

# Dotfiles directories
DOTFILES_DIR := $(CURDIR)
OPT_DIR = $(DOTFILES_DIR)/opt
LOCAL_DIR = $(DOTFILES_DIR)/$(PKG_SYS_LOCAL)

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache

# Sub directories with makefiles
SUBDIRS = vim zsh

all: setup link $(SUBDIRS)

setup:
	@stow -t $(HOME) stow
	@mkdir -p $(LOCAL_DIR)
	@mkdir -p $(XDG_CONFIG_HOME)/less
	@mkdir -p $(XDG_CACHE_HOME)/less

link: setup
	@stow -t $(HOME) $(PKG_ROOT_DEFAULT)
	@stow -t $(HOME) -d $(OPT_DIR) $(PKG_OPT_DEFAULT)
ifeq ($(shell uname), Darwin)
	@stow -t $(HOME) $(PKG_SYS_MAC)
endif

unlink: setup
	@stow -D -t $(HOME) $(PKG_ROOT_ALL)
	@stow -D -t $(HOME) -d $(OPT_DIR) $(PKG_OPT_ALL)

chklink: setup
	@stow -n -v -t $(HOME) $(PKG_ROOT_ALL)
	@stow -n -v -t $(HOME) -d $(OPT_DIR) $(PKG_OPT_ALL)

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
