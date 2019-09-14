DOTFILES_DIR = ${HOME}/.dotfiles

SUBDIRS = vim zsh local

PKG_COMMON = bash fasd git homebrew local vim tmux utility zsh
PKG_MOD_LANG_COMMON = node python ruby
PKG_MOD_LANG_JVM = java kotlin scala sdkman
PGK_MOD_LANG_SYS = golang rust
PKG_MOD_LANG_ALL = $(PKG_MOD_LANG_COMMON) $(PKG_MOD_LANG_JVM) $(PKG_MOD_LANG_SYS)
PKG_MOD_TOOLS = docker kubernetes redis
PKG_MOD_ALL = $(PKG_MOD_LANG_ALL) $(PKG_MOD_TOOLS)
PKG_OS_MAC = macos
PKG_OS_ALL = $(PKG_OS_MAC)
PKG_ALL = $(PKG_COMMON) $(PKG_MOD_ALL)

PKG_CORE_MOD = $(PKG_MOD_LANG_COMMON) docker
PKG_CORE_ALL = $(PKG_COMMON) $(PKG_CORE_MOD)

all: setup link $(SUBDIRS)

setup:
	@mkdir -p "$(CURDIR)/local"
	@stow -t ${HOME} stow

link: setup
	@stow -t ${HOME} $(PKG_CORE_ALL)
ifeq ($(shell uname), Darwin)
	@stow -t ${HOME} $(PKG_OS_MAC)
endif

unlink: setup
	@stow -D -t ${HOME} $(PKG_ALL)

chklink: setup
	@stow -n -v -t ${HOME} $(PKG_ALL)

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
