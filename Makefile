DOTFILES_DIR = ${HOME}/.dotfiles
MODULES_DIR = $(DOTFILES_DIR)/modules

SUBDIRS = vim zsh local

PKG_CORE = bash git homebrew local vim tmux zsh
PKG_TOOLS_CORE = fasd docker utility
PKG_LANG_CORE = node python ruby
PKG_TOOLS_EXTRA = asdf gcloud kubernetes redis
PKG_LANG_EXTRA = dotnet golang java kotlin rust scala sdkman
PKG_OS_MAC = @macos

PKG_ALL_ROOT = $(PKG_CORE)
PKG_ALL_MOD = $(PKG_LANG_CORE) $(PKG_LANG_EXTRA) $(PKG_TOOLS_CORE) $(PKG_TOOLS_EXTRA)

PKG_DEFAULT = $(PKG_CORE)
PKG_DEFAULT_MODS = $(PKG_LANG_CORE) $(PKG_TOOLS_CORE)

all: setup link $(SUBDIRS)

setup:
	@mkdir -p "$(CURDIR)/local"
	@stow -t ${HOME} stow

link: setup
	@stow -t ${HOME} $(PKG_DEFAULT)
	@stow -t ${HOME} -d $(MODULES_DIR) $(PKG_DEFAULT_MODS)
ifeq ($(shell uname), Darwin)
	@stow -t ${HOME} $(PKG_OS_MAC)
endif

unlink: setup
	@stow -D -t ${HOME} $(PKG_ALL_ROOT)
	@stow -D -t ${HOME} -d $(MODULES_DIR) $(PKG_ALL_MOD)
ifeq ($(shell uname), Darwin)
	@stow -D -t ${HOME} $(PKG_OS_MAC)
endif

chklink: setup
	@stow -n -v -t ${HOME} $(PKG_ALL_ROOT)
	@stow -n -v -t ${HOME} -d $(MODULES_DIR) $(PKG_ALL_MOD)
ifeq ($(shell uname), Darwin)
	@stow -n -v -t ${HOME} $(PKG_OS_MAC)
endif

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
