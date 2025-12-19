-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/editor/explorer.lua
-- =============================================================================
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end,
			desc = "Explorer NeoTree (Root Dir)",
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.icons",
	},
	opts = {
		close_if_last_window = true,

		-- CUSTOM COMMANDS
		commands = {
			change_context = function(state)
				local node = state.tree:get_node()
				local path = node.path

				-- If user clicked a file, grab its parent directory
				if node.type == "file" then
					path = node:get_parent_id()
				end

				-- 1. Change the Global Neovim Directory
				vim.api.nvim_set_current_dir(path)

				-- 2. Zoom Neo-tree into that directory
				require("neo-tree.sources.filesystem.commands").set_root(state)

				-- 3. Notify
				local Snacks = package.loaded["snacks"]
				if Snacks then
					Snacks.notify.info("Workspace moved to:\n" .. path, { title = "Context Switch" })
				else
					print("CWD: " .. path)
				end
			end,
		},

		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			hijack_netrw_behavior = "open_default",
		},
		window = {
			position = "left",
			width = 30,
			mappings = {
				-- STANDARD NAVIGATION
				["l"] = "open", -- Open file / Expand folder
				["h"] = "close_node", -- Collapse folder
				["<space>"] = "none",
				["<bs>"] = "navigate_up",
				["."] = "set_root",

				-- WORKFLOW NAVIGATION (The H/L Logic)
				["H"] = "navigate_up", -- Go Up (Parent Directory)
				["L"] = "change_context", -- Go In (Set as Workspace Root)
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
			},
			modified = { symbol = "●" },
			git_status = {
				symbols = {
					added = "✚",
					modified = "",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
	},
}
