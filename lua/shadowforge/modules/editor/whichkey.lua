-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/editor/whichkey.lua
-- =============================================================================
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix", -- Modern, clean aesthetic
		spec = {
			{ "<leader>f", group = "file/find" },
			{ "<leader>c", group = "code" },
			{ "<leader>g", group = "git" },
			{ "<leader>t", group = "toggle/theme" },
			{ "<leader>u", group = "ui" },
			{ "<leader>x", group = "diagnostics/quickfix" },
		},
	},
}
