DOTFILES_DIR = ${HOME}/.dotfiles
MODULES_DIR = $(DOTFILES_DIR)/modules
PKG_SYS_LOCAL = @local
PKG_SYS_MAC = @macos
PKG_CORE = bash git homebrew vim tmux zsh
PKG_TOOLS_CORE = fasd docker utility
PKG_LANG_CORE = node python ruby
PKG_EXTRA_TOOLS = asdf gcloud kubernetes redis
PKG_EXTRA_LANG = dotnet golang java kotlin rust scala sdkman
PKG_ALL_SYS = $(PKG_SYS_LOCAL) $(PKG_SYS_MAC)
PKG_ALL_ROOT = $(PKG_CORE) $(PKG_ALL_SYS)
PKG_ALL_MOD = $(PKG_TOOLS_CORE) $(PKG_LANG_CORE) $(PKG_EXTRA_TOOLS) $(PKG_EXTRA_LANG)
PKG_DEFAULT = $(PKG_CORE) $(PKG_SYS_LOCAL)
PKG_DEFAULT_MODS = $(PKG_LANG_CORE) $(PKG_TOOLS_CORE)
SUBDIRS = $(PKG_SYS_LOCAL) vim zsh

all: setup link $(SUBDIRS)

setup:
	@mkdir -p $(CURDIR)/$(PKG_SYS_LOCAL)
	@stow -t ${HOME} stow

link: setup
	@stow -t ${HOME} $(PKG_DEFAULT)
	@stow -t ${HOME} -d $(MODULES_DIR) $(PKG_DEFAULT_MODS)
ifeq ($(shell uname), Darwin)
	@stow -t ${HOME} $(PKG_SYS_MAC)
endif

unlink: setup
	@stow -D -t ${HOME} $(PKG_ALL_ROOT)
	@stow -D -t ${HOME} -d $(MODULES_DIR) $(PKG_ALL_MOD)

chklink: setup
	@stow -n -v -t ${HOME} $(PKG_ALL_ROOT)
	@stow -n -v -t ${HOME} -d $(MODULES_DIR) $(PKG_ALL_MOD)

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: $(SUBDIRS)
