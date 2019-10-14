# Package bundles
PKG_SYS_LOCAL = @local
PKG_SYS_MAC = @macos
PKG_CORE = bash git homebrew vim ssh tmux utility zsh
PKG_TOOLS_CORE = fasd docker
PKG_LANG_CORE = node python ruby
PKG_LANG_JVM = gradle java kotlin maven scala sdkman
PKG_EXTRA_TOOLS = asdf aws gcloud kubernetes redis
PKG_EXTRA_LANG = dotnet golang rust $(PKG_LANG_JVM)
PKG_ALL_SYS = $(PKG_SYS_LOCAL) $(PKG_SYS_MAC)
PKG_ALL_ROOT = $(PKG_CORE) $(PKG_ALL_SYS)
PKG_ALL_MOD = $(PKG_TOOLS_CORE) $(PKG_LANG_CORE) $(PKG_EXTRA_TOOLS) $(PKG_EXTRA_LANG)
PKG_DEFAULT = $(PKG_CORE) $(PKG_SYS_LOCAL)
PKG_DEFAULT_MODS = $(PKG_LANG_CORE) $(PKG_TOOLS_CORE)

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
	@stow -t $(HOME) $(PKG_DEFAULT)
	@stow -t $(HOME) -d $(OPT_DIR) $(PKG_DEFAULT_MODS)
ifeq ($(shell uname), Darwin)
	@stow -t $(HOME) $(PKG_SYS_MAC)
endif

unlink: setup
	@stow -D -t $(HOME) $(PKG_ALL_ROOT)
	@stow -D -t $(HOME) -d $(OPT_DIR) $(PKG_ALL_MOD)

chklink: setup
	@stow -n -v -t $(HOME) $(PKG_ALL_ROOT)
	@stow -n -v -t $(HOME) -d $(OPT_DIR) $(PKG_ALL_MOD)

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
