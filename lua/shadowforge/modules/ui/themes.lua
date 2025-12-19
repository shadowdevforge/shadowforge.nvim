return {
	-- 1. Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = function()
			local transparent = require("shadowforge.config").options.ui.transparency
			return {
				flavour = "mocha",
				transparent_background = transparent,
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					mini = { enabled = true },
					telescope = { enabled = true },
					mason = true,
					noice = true,
					notify = false,
				},
			}
		end,
		-- Persistence logic: Reads the saved theme on startup
		init = function()
			local path = vim.fn.stdpath("data") .. "/shadowforge_theme"
			if vim.fn.filereadable(path) == 1 then
				local file = io.open(path, "r")
				if file then
					local theme = file:read("*a")
					file:close()
					theme = theme:gsub("%s+", "")
					if theme and #theme > 0 then
						vim.schedule(function()
							pcall(vim.cmd.colorscheme, theme)
						end)
						return
					end
				end
			end
			vim.schedule(function()
				vim.cmd.colorscheme("catppuccin")
			end)
		end,
	},

	-- 2. Other Themes
	{ "folke/tokyonight.nvim", lazy = false, opts = { style = "night" } },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, opts = { variant = "moon" } },
	{ "rebelot/kanagawa.nvim", lazy = false, opts = { theme = "wave" } },
	{ "samharju/synthweave.nvim", lazy = false, priority = 1000 },
}
