return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  lazy = false,
  enabled = true,
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = require("plugins.dashboard.logos")["random"]
    dashboard.section.buttons.val = {
      dashboard.button("f", "  " .. " Find file", ":Telescope find_files<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 0

    if vim.o.filetype == "lazy" then
      vim.notify("Missing plugins installed!", vim.log.levels.INFO, { title = "lazy.nvim" })
      vim.cmd.close()
      require("alpha").setup(dashboard.opts)
      require("lazy").show()
    else
      require("alpha").setup(dashboard.opts)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        local version = "    v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local plugins = "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = "\t" .. version .. "\t" .. plugins .. "\n"
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
