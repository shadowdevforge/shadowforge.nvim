-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/ui/dashboard.lua
-- =============================================================================
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- 1. FOCUS / DIMMING (Enabled in config, but off by default)
		-- Activate with <leader>sd
		dim = {
			scope = {
				min_size = 5,
				max_size = 20,
				siblings = true,
			},
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				easing = "outQuad",
				duration = { step = 20, total = 300 },
			},
		},

		-- 2. INDENT GUIDES
		indent = {
			enabled = true,
			char = "│",
			scope = {
				enabled = true,
				char = "│",
			},
		},

		-- 3. SMOOTH SCROLLING
		scroll = { enabled = true },

		-- 4. BETTER UI INPUT
		input = { enabled = true },

		-- 5. UTILS
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		words = { enabled = true },

		-- 6. DASHBOARD
		dashboard = {
			enabled = true,
			preset = {
				header = [[
                                       
▄█████ ▄▄ ▄▄  ▄▄▄  ▄▄▄▄   ▄▄▄  ▄▄   ▄▄ 
▀▀▀▄▄▄ ██▄██ ██▀██ ██▀██ ██▀██ ██ ▄ ██ 
█████▀ ██ ██ ██▀██ ████▀ ▀███▀  ▀█▀█▀  
                                       
    ██████ ▄▄▄  ▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄      
    ██▄▄  ██▀██ ██▄█▄ ██ ▄▄ ██▄▄       
    ██    ▀███▀ ██ ██ ▀███▀ ██▄▄▄      

        ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	keys = {
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		-- Toggle Focus Mode (Opt-in)
		{
			"<leader>sd",
			function()
				if vim.b.snacks_dim then
					Snacks.dim.disable()
					vim.b.snacks_dim = false
				else
					Snacks.dim.enable()
					vim.b.snacks_dim = true
				end
			end,
			desc = "Toggle Focus/Dim",
		},
	},
}
