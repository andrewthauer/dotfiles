#!/usr/bin/env bash
#
# Linux (KDE Plasma) default configuration settings
#
# Uses kwriteconfig5 (Plasma 5) or kwriteconfig6 (Plasma 6)
# Config files are stored in ~/.config/
#
# To explore settings:
#   - Check ~/.config/ for .rc files (kwinrc, kdeglobals, etc.)
#   - Use `kreadconfig5` to read values
#   - Change settings in System Settings and diff config files
#

# Detect KDE Plasma version
if command -v kwriteconfig6 &>/dev/null; then
  KWRITE="kwriteconfig6"
elif command -v kwriteconfig5 &>/dev/null; then
  KWRITE="kwriteconfig5"
else
  echo "KDE Plasma not detected. Exiting."
  exit 1
fi

# =============================================================================
# Appearance
# =============================================================================

# Dark theme
$KWRITE --file kdeglobals --group General --key ColorScheme 'BreezeDark'

# =============================================================================
# Input - Keyboard
# =============================================================================

# Set fast keyboard repeat rate
# RepeatDelay: time before repeat starts (milliseconds)
# RepeatRate: characters per second
$KWRITE --file kcminputrc --group Keyboard --key RepeatDelay 200
$KWRITE --file kcminputrc --group Keyboard --key RepeatRate 60

# =============================================================================
# Input - Mouse
# =============================================================================

# Set mouse scroll speed (1-20, higher = faster)
$KWRITE --file kcminputrc --group Mouse --key ScrollFactor 3

# =============================================================================
# Sound
# =============================================================================

# Disable bell/beep
$KWRITE --file kdeglobals --group General --key BellVolume 0

# Disable event sounds
$KWRITE --file kdeglobals --group Sounds --key Enable false

# =============================================================================
# Default Applications
# =============================================================================

# Set Firefox Developer Edition as default browser
if command -v firefox-developer-edition &>/dev/null; then
  xdg-settings set default-web-browser firefox-developer-edition.desktop
elif [ -f /usr/share/applications/firefox-developer-edition.desktop ]; then
  xdg-settings set default-web-browser firefox-developer-edition.desktop
else
  echo "⚠️  Firefox Developer Edition not found, skipping default browser setting"
fi

# Set Ghostty as default terminal
if command -v ghostty &>/dev/null; then
  $KWRITE --file kdeglobals --group General --key TerminalApplication 'ghostty'
  $KWRITE --file kdeglobals --group General --key TerminalService 'com.mitchellh.ghostty.desktop'
else
  echo "⚠️  Ghostty not found, skipping default terminal setting"
fi

# Set Zed as default text editor
if command -v zed &>/dev/null; then
  $KWRITE --file kdeglobals --group General --key BrowserApplication '!zed'
elif [ -f /usr/share/applications/dev.zed.Zed.desktop ]; then
  $KWRITE --file kdeglobals --group General --key BrowserApplication 'dev.zed.Zed.desktop'
else
  echo "⚠️  Zed not found, skipping default editor setting"
fi

# =============================================================================
# File Manager (Dolphin)
# =============================================================================

# Show hidden files
$KWRITE --file dolphinrc --group General --key ShowHiddenFiles true

# Show full path in title bar
$KWRITE --file dolphinrc --group General --key ShowFullPath true

# =============================================================================
# Apply settings
# =============================================================================

echo "✅ Done"
echo "Some changes may require logging out and back in to take effect."
echo "You can also run: qdbus org.kde.KWin /KWin reconfigure"
