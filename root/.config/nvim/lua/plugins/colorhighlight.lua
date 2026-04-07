return {
	dir = vim.fn.stdpath("config"),
	name = "colorhighlight",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "ColorHighlightToggle", "ColorHighlightEnable", "ColorHighlightDisable" },
	config = function()
		require("colorhighlight").setup()
	end,
}
