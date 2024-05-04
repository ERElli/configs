return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader><Space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (root)" },
	},
	config = true,
}
