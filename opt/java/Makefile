PARENT_DIR = $(CURDIR)/..

# XDG directories
XDG_DATA_HOME := $(HOME)/.local/share

# macOS specific
LAUNCH_AGENTS = $(HOME)/Library/LaunchAgents
SOURCE_ENV_PLIST = $(CURDIR)/_macos/Library/LaunchAgents/java-env.plist
TARGET_ENV_PLIST = $(LAUNCH_AGENTS)/java-env.plist

all: java
java: setup link

setup:
	@mkdir -p $(XDG_DATA_HOME)/sdk/{java,maven,maven}

link: setup
	@stow -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))
ifeq ($(shell uname), Darwin)
	@ln -fs $(SOURCE_ENV_PLIST) $(TARGET_ENV_PLIST)
	@launchctl unload $(TARGET_ENV_PLIST)
	@launchctl load $(TARGET_ENV_PLIST)
endif

unlink:
	@stow -D -d $(PARENT_DIR) -t ~ -S $(notdir $(CURDIR))
ifeq ($(shell uname), Darwin)
	@launchctl unload $(TARGET_ENV_PLIST)
	@rm -f $(TARGET_ENV_PLIST)
endif
