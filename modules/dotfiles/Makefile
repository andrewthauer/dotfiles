MANPATH = share/man/man1

PANDOC := $(shell command -v pandoc 2> /dev/null)

all:
	@echo no default task

build: dotfiles.1

dotfiles.1: $(MANPATH)/dotfiles.1.md
ifdef PANDOC
	pandoc -s -t man $(MANPATH)/dotfiles.1.md -o $(MANPATH)/dotfiles.1
else
	@echo pandoc not found
endif

.PHONY: all
