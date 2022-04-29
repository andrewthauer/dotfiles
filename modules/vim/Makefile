PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_DATA_HOME := $(HOME)/.local/share

all: link vim

link:
	@stow -t $(HOME) -d $(PARENT_DIR) -S $(notdir $(CURDIR))

unlink:
	@stow -t $(HOME) -d $(PARENT_DIR) -D $(notdir $(CURDIR))

vim:
	@echo "Installing vim-plug"
	@mkdir -p "$(XDG_DATA_HOME)/nvim/site/autoload"
	@curl -sfLo $(XDG_DATA_HOME)/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo "Install plugins"
	@nvim +PlugInstall +qall
