DOTFILES_DIR = $(CURDIR)/..

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
XDG_BIN_HOME := $(HOME)/.local/bin

shell: all

all: link

link: setup
	@stow -d $(DOTFILES_DIR) -t ~ -S shell

unlink:
	@stow -D -d $(DOTFILES_DIR) -t ~ -S shell

cheat:
	@curl https://cheat.sh/:cht.sh > $(XDG_BIN_HOME)/cht.sh | chmod +x $(XDG_BIN_HOME)/cht.sh
	@mkdir -p $(XDG_DATA_HOME)/zsh/functions
	@curl https://cheat.sh/:zsh > $(XDG_DATA_HOME)/zsh/functions/_cht
