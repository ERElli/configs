local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim config
require("lazy").setup("plugins", {
	change_detection = { enabled = false },
	defaults = { lazy = true, version = nil },
	-- install = { missing = true },
	install = { missing = true, colorscheme = {"tokyonight", "gruvbox" } },
	checker = { enabled = true, frequency = 86400 },
})

vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
