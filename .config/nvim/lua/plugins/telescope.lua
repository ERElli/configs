return {
  "nvim-telescope/telescope.nvim", tag = "0.1.5",
  lazy = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {"<leader><Space>", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
  },
  config = true,
}
