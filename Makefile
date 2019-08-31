DOTFILES_DIR = ${HOME}/.dotfiles
SYMLINK = ${DOTFILES_DIR}/bin/symlink

SUBDIRS = modules local

all: setup $(SUBDIRS)

setup:
	mkdir -p "$(CURDIR)/local"
	mkdir -p "$(CURDIR)/repos"
	mkdir -p "$(CURDIR)/zfunc"
	@$(SYMLINK) $(CURDIR) $(DOTFILES_DIR)

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: all setup $(SUBDIRS)
