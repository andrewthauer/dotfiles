#!/usr/bin/env bash
#
# macOS default configuration settings
#
# https://macos-defaults.com/
#
# reference:
#   defaults domains | awk '{gsub(", ", "\n", $0)}1' | sort
#

# Default dotfiles home directory
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Prompt for admin password upfront
sudo -v

# =============================================================================
# General UI
# =============================================================================

# Dark Theme
# defaults write -g AppleInterfaceStyle -string Dark

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Disable animations when opening and closing windows.
# defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Accelerated playback when adjusting the window size (Cocoa applications)
# defaults write -g NSWindowResizeTime -float 0.001

# Disable animations when opening a Quick Look window
# defaults write -g QLPanelAnimationDuration -float 0

# Prefer tabs when opening windows
defaults write -g AppleWindowTabbingMode -string "always"

# =============================================================================
# Input - Keyboard
# =============================================================================

# Set fast keyboard repeat rate
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
# defaults write -g AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Use fn + fkey for special behavior, not fkey alone
defaults write -g com.apple.keyboard.fnState -bool true

# Disable smart quotes
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# =============================================================================
# Input - Keyboard Shortcuts
# =============================================================================

# Modifier key legend:
#  @ = command
#  ^ = control
#  ~ = option
#  $ = shift

# Example
# defaults write -g NSUserKeyEquivalents -dict-add "Show Next Tab" "@~\U2192"
# defaults write -g NSUserKeyEquivalents -dict-add "Maximize" "@$\U004D"

# TODO - Disable keyboard shorcuts in System Preferences > Mission Control
# - Mission Control
# - Show Notification -> Center Ctrl+Option+F8
# - Application windows
# - Show Desktop
# - Show Dashboard

# Disable input sources switching (System Preferences > Keyboard > Shortcuts > Input Sources)
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "{ enabled = 0; value = { parameters = (32, 49, 262144); type = 'standard'; }; }"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "{ enabled = 0; value = { parameters = (32, 49, 786432); type = 'standard'; }; }"

# Disable spaces left
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 "<dict><key>enabled</key><false/></dict>"
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 80 "<dict><key>enabled</key><false/></dict>"

# Disable spaces right
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 "<dict><key>enabled</key><false/></dict>"
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 82 "<dict><key>enabled</key><false/></dict>"

# =============================================================================
# Input - Mouse, Trackpad
# =============================================================================

# Enable tap to click (Trackpad) for this user and for the login screen
# defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
# defaults -currentHost write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults -currentHost write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults write -g com.apple.mouse.tapBehavior -int 1
# defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable trackpad dragging
# defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
# defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
# defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFinder -bool false

# disable "natural" (touchscreen-style) scrolling
# defaults write -g com.apple.swipescrolldirection -bool false

# enable ctrl modifier key + scrolling for zoom in/out
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -int 262144
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -int 262144

# OTHER (TODO)

# disable mission control - ctrl up/down
# disable trackpad lookup details & info

# =============================================================================
# Screen / Video
# =============================================================================

# Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
# defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# defaults write -g AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# =============================================================================
# Sound
# =============================================================================

# Disable the sound effects on boot
# sudo nvram StartupMute=%01

# Disable the power chime
defaults write com.apple.PowerChime ChimeOnAllHardware -bool false

# Disable feedback sounds
defaults write -g com.apple.sound.beep.feedback -bool false
defaults write -g com.apple.sound.beep.flash -bool false
defaults write -g com.apple.sound.beep.volume -int 0

# Disable ui sound effects (empty trash, screen capture, etc.)
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

# =============================================================================
# Menu Bar
# =============================================================================

# Hide language input source menu bar
defaults write com.apple.TextInputMenu "visible" -bool false
defaults write com.apple.TextInputMenuAgent "NSStatusItem Visible Item-0" -bool false

# Digital clock with a non-flashing separator
# defaults write com.apple.menuextra.clock FlashDateSeparator -bool false
# defaults write com.apple.menuextra.clock IsAnalog -bool false

# =============================================================================
# Dock
# =============================================================================

# Set the icon size of Dock items (in pixels)
defaults write com.apple.dock tilesize -int 36

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Auto-hiding Dock delay (remove)
defaults write com.apple.dock autohide-delay -float 0.2

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Change minimize/maximize window effect
# defaults write com.apple.dock mineffect -string "genie"

# Enable spring loading for all Dock items
# defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
# defaults write com.apple.dock show-process-indicators -bool true

# Speed up Mission Control animations
# defaults write com.apple.dock expose-animation-duration -float 0.1

# Enable highlight hover effect for the grid view of a stack (Dock)
# defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
# defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# =============================================================================
# Dock - persistent apps
# =============================================================================

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array

# Add a spacer to the left side of the Dock (where the applications are)
# defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Add a spacer to the right side of the Dock (where the Trash is)
# defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# =============================================================================
# Mission Control, Spaces & Dashboard
# =============================================================================

# Don’t show Dashboard as a Space
# defaults write com.apple.dock dashboard-in-overlay -bool true

# Disable Mission Control
# defaults write com.apple.dock mcx-expose-disabled -bool false

# Disable Dashboard
# defaults write com.apple.dashboard mcx-disabled -bool false

# Don’t automatically rearrange Spaces based on most recent use
# defaults write com.apple.dock mru-spaces -bool false

# Show the dashboard as an overlay
# defaults write com.apple.dashboard dashboard-enabled-state -int 3
# defaults write com.apple.dashboard enabled-state -int 3

# Don't automatically switch to a space containing windows for an app
# defaults write com.apple.dock workspaces-auto-swoosh -bool false

# Don’t group windows by application in Mission Control (use the old Exposé behavior instead)
# defaults write com.apple.dock expose-group-by-app -bool false

# =============================================================================
# Hot corners
# =============================================================================

# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left screen corner - disabled
# defaults write com.apple.dock wvous-tl-corner -int [value]
# defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner - disabled
# defaults write com.apple.dock wvous-tr-corner -int [value]
# defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner - disabled
# defaults write com.apple.dock wvous-bl-corner -int [value]
# defaults write com.apple.dock wvous-bl-modifier -int 0

# bottom right screen corner — disabled
# defaults write com.apple.dock wvous-br-corner -int [value]
# defaults write com.apple.dock wvous-br-modifier -int 0

# =============================================================================
# Finder
# =============================================================================

# Show all filename extensions
defaults write -g AppleShowAllExtensions -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Default view syle to columns
defaults write com.apple.finder FXPreferredViewStyle clmv

# Set user's home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Show icons for external hard drives & removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Do not show icons for hard drives & servers desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool false
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Sidebar - Show ejectables, removables, servers
defaults write com.apple.sidebarlists systemitems -dict-add ShowEjectables -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowRemovable -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowServers -bool true

# Sidebar - Do not show hard disks
defaults write com.apple.sidebarlists systemitems -dict-add ShowHardDisks -bool false

# =============================================================================
# Terminal
# =============================================================================

# Use custom theme for Terminal.app
# TERMINAL_THEME="Zenburn"
# open "${XDG_CONFIG_HOME}/terminal/${TERMINAL_THEME}.terminal"
# sleep 1 # Wait a bit to make sure the theme is loaded
# defaults write com.apple.Terminal "Default Window Settings" -string "${TERMINAL_THEME}"
# defaults write com.apple.Terminal "Startup Window Settings" -string "${TERMINAL_THEME}"

# =============================================================================
# Other applications
# =============================================================================

# Dash doc sync folder path
# defaults write com.kapeli.dashdoc "syncFolderPath" -string "${XDG_CONFIG_HOME:-$HOME/.config}"

# =============================================================================
# Kill affected applications
# =============================================================================

for app in \
  "Activity Monitor" "cfprefsd" "Dock" "Finder" "SystemUIServer" "Terminal"; do
  killall "${app}" >/dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
