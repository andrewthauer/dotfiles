DOTFILES_DIR = ${HOME}/.dotfiles

SUBDIRS = vim zsh local

PKG_CORE = bash fasd docker git homebrew local utility vim tmux zsh
PKG_LANG_CORE = node python ruby
PKG_LANG_SYS = golang rust
PKG_LANG_JVM = java kotlin scala sdkman
PKG_TOOLS = kubernetes redis
PKG_MACOS = macos hammerspoon karabiner
PKG_ALL = $(PKG_CORE) $(PKG_LANG_CORE) $(PKG_LANG_SYS) $(PKG_JVM) $(PKG_TOOLS) $(PKG_MACOS)

all: setup link $(SUBDIRS)

setup:
	@mkdir -p "$(CURDIR)/local"
	@stow -t ${HOME} stow

link: setup
	@stow -t ${HOME} $(PKG_CORE) $(PKG_LANG_CORE)
ifeq ($(shell uname), Darwin)
	@stow -t ${HOME} $(PKG_MACOS)
endif

linkall: setup
	@stow -t ${HOME} $(PKG_ALL)

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
