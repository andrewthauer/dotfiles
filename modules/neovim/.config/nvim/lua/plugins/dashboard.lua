return {
  -- dashboard starter page
  -- https://github.com/nvimdev/dashboard-nvim
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "ibhagwan/fzf-lua" },
    },
    opts = function()
      local logo = [[
░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█
░█░█░█▀▀░█░█░▀▄▀░░█░░█░█
░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            -- stylua: ignore start
            { action = "FzfLua files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "FzfLua oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "FzfLua live_grep", desc = " Find text", icon = " ", key = "g" },
            { action = "NeovimProjectDiscover", desc = " Projects", icon = " ", key = "p" },
            { action = function() require("session_manager").load_current_dir_session(false) end, desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "Mason", desc = " Mason", icon = "🝙 ", key = "m" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
            -- stylua: ignore end
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      -- widen action buttons to look nicer
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      return opts
    end,
  },
}
