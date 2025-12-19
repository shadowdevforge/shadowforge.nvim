-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/ui/themery.lua
-- =============================================================================
return {
	"zaldih/themery.nvim",
	lazy = false,
	cmd = "Themery",
	keys = {
		{ "<leader>th", "<cmd>Themery<cr>", desc = "Theme Switcher" },
	},
	opts = {
		themes = {
			"catppuccin-mocha",
			"catppuccin-macchiato",
			"catppuccin-frappe",
			"tokyonight-moon",
			"tokyonight-storm",
			"tokyonight-night",
			"rose-pine-moon",
			"kanagawa-wave",
			"kanagawa-dragon",
			"synthweave",
			"synthweave-transparent",
			"catppuccin-latte",
			"tokyonight-day",
			"rose-pine-dawn",
			"kanagawa-lotus",
		},
		livePreview = true,
		layout = "float",
		border = "rounded",
		title = "   ShadowForge Themes ",
	},
	config = function(_, opts)
		require("themery").setup(opts)
	end,
}
