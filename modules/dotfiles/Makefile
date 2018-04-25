MANPATH = share/man/man1

all: dotfiles.1

dotfiles.1: $(MANPATH)/dotfiles.1.md
	pandoc -s -t man $(MANPATH)/dotfiles.1.md -o $(MANPATH)/dotfiles.1

.PHONY: all
