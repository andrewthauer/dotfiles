# Package bundles
OPT_PKGS = $(sort $(notdir $(wildcard ./opt/*)))
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
DEFAULT_PKGS = asdf fasd fzf git shell stow tmux vim
SYSTEM_PKGS =

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# Sub directories with makefiles
SUBDIRS = etc

# macOS specific settings
ifeq ($(shell uname), Darwin)
	SYSTEM_PKGS = macos homebrew
	SUBDIRS := $(SUBDIRS) opt/$(SYSTEM_PKG)
	DEFAULT_PKGS := $(DEFAULT_PKGS) $(SYSTEM_PKGS)
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	SYSTEM_PKGS = linux
	SUBDIRS := $(SUBDIRS) opt/$(SYSTEM_PKGS)
endif

all: setup link $(SUBDIRS)

shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*' ! -name 'time-zsh')
	@shellcheck $$(find . -name '*.sh')

check-shfmt:
	@shfmt -i 2 -ci -l $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -i 2 -ci -l $$(find . -name '*.sh')

lint: shellcheck check-shfmt

dummy:
	echo $(sort $(notdir $(wildcard ./opt*/*)))

setup:
	@mkdir -p $(CURDIR)/local
	@mkdir -p $(XDG_CONFIG_HOME)/{profile.d,shell.d}
	@mkdir -p $(XDG_CONFIG_HOME)/{git,less}
	@mkdir -p $(HOME)/.ssh/config.d
	@mkdir -p $(XDG_CACHE_HOME)/less
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)
	@stow -t $(HOME) -d $(CURDIR)/opt -S stow
ifeq ($(shell uname), Darwin)
	@mkdir -p $(XDG_CONFIG_HOME)/homebrew
endif

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S local
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(DEFAULT_PKGS)
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKGS)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S etc local
	@stow -D -t $(HOME) -d $(CURDIR)/opt -S $(DEFAULT_PKGS)
	@stow -D -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKGS)

chklink:
	@echo "\n--- Files from 'etc' currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S etc
	@echo "\n--- System package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKGS)
	@echo "\n--- Optional package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@echo "\n--- Local packages currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S local
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(XDG_BIN_HOME)
	@chkstow -a -b -t $(XDG_LIB_HOME)
ifeq ($(shell uname), Darwin)
	@chkstow -a -b -t $(LAUNCH_AGENTS)
endif

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: .DEFAULT $(SUBDIRS)
