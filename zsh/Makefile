DOTFILES_DIR = $(CURDIR)/..
BIN_DIR = $(DOTFILES_DIR)/bin
LOCAL_SHARE_DIR = $(HOME)/.local/share

GITHUB_INSTALL = $(BIN_DIR)/github-install

all: setup link plugins

setup:
	@mkdir -p "$(LOCAL_SHARE_DIR)"

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S zsh

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S zsh

plugins: setup
	@$(GITHUB_INSTALL) -n sindresorhus/pure $(LOCAL_SHARE_DIR)

zsh: all
