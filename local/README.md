# Local Configuration

## Setup

Here is an example `local/Makefile` for symlnking local settings:

```makefile
DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin
REPOS_DIR = $(DOTFILES_DIR)/repos
GITHUB_INSTALL = $(BIN_DIR)/github-install
SYMLINK = $(BIN_DIR)/symlink

SUBDIRS =

all: local secrets

local:
    @$(SYMLINK) $(CURDIR)/git/.gitconfig ~/.gitconfig.local
    @$(SYMLINK) $(CURDIR)/homebrew/Brewfile ~/.Brewfile.local
    @$(SYMLINK) $(CURDIR)/zsh/.zprofile ~/.zprofile.local
    @$(SYMLINK) $(CURDIR)/zsh/.zshrc ~/.zshrc.local

secrets:
    @$(SYMLINK) $(CURDIR)/secrets/aws ~/.aws
    @$(SYMLINK) $(CURDIR)/secrets/gnupg ~/.gnupg
    @$(SYMLINK) $(CURDIR)/secrets/ssh/id_rsa ~/.ssh/id_rsa
    @$(SYMLINK) $(CURDIR)/secrets/ssh/id_rsa.pub ~/.ssh/id_rsa.pub

.DEFAULT: $(SUBDIRS)
    @for dir in $(SUBDIRS); do \
        $(MAKE) -C $$dir $(MAKECMDGOALS); \
    done

.PHONY: all local secrets
```

You can then run `make` from this directory to symlink all the specified files.
Alternatively you can also run `make local` or `make secrets` from the dotfiles
root directory (which will delegate the work to the local make file).
