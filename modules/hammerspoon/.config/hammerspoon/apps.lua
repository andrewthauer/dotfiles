--
-- hammerspoon app bundle IDs
--

local M = {}

-- Apps (use mac-app-id 'app name')
M.CHROME = "com.google.Chrome"
M.CLAUDE_DESKTOP = "com.anthropic.claudefordesktop"
M.FINDER = "com.apple.finder"
M.FIREFOX = "org.mozilla.firefoxdeveloperedition"
M.GHOSTTY = "com.mitchellh.ghostty"
M.HOME_ASSISTANT = "io.robbie.HomeAssistant"
M.INTELLIJ = "com.jetbrains.intellij"
M.KEYMAPP = "io.zsa.keymapp"
M.NOTION = "notion.id"
M.ONENOTE = "com.microsoft.onenote.mac"
M.ONEPASSWORD = "com.1password.1password"
M.SLACK = "com.tinyspeck.slackmacgap"
M.TODOIST = "com.todoist.mac.Todoist"
M.VSCODE = "com.microsoft.VSCode"
M.ZED = "dev.zed.Zed-Preview"

-- Default apps
M.AI_ASSISTANT = M.CLAUDE_DESKTOP
M.BROWSER = M.CHROME
M.EDITOR = M.ZED
M.TERMINAL = M.GHOSTTY

return M
