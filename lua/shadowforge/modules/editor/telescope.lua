-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/editor/telescope.lua
-- =============================================================================
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	keys = {
		-- The Essentials
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
		{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Grep Text" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
	},
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			get_selection_window = function()
				local wins = vim.api.nvim_list_wins()
				table.insert(wins, 1, vim.api.nvim_get_current_win())
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].buftype == "" then
						return win
					end
				end
				return 0
			end,
			mappings = {
				i = {
					["<c-d>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
					["<c-u>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
					["<c-j>"] = function(...)
						return require("telescope.actions").move_selection_next(...)
					end,
					["<c-k>"] = function(...)
						return require("telescope.actions").move_selection_previous(...)
					end,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = false,
				hidden = true,
			},
		},
	},
}
