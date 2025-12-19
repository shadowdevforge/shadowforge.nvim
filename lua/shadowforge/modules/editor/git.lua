-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/editor/git.lua
-- =============================================================================
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		current_line_blame = true, -- Shows who edited the line next to code
		current_line_blame_opts = {
			delay = 500,
			virt_text_pos = "eol", -- End of line
		},
	},
}
