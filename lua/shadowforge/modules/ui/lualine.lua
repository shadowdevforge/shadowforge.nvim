-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/ui/lualine.lua
-- =============================================================================
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		-- 1. DEFINE THE PALETTE (Independent Source of Truth)
		local mocha = require("catppuccin.palettes").get_palette("mocha") or {}

		local colors = {
			bg = "NONE", -- Force transparency
			fg = mocha.text or "#cdd6f4",
			yellow = mocha.yellow or "#f9e2af",
			cyan = mocha.sky or "#89dceb",
			black = mocha.mantle or "#181825",
			green = mocha.green or "#a6e3a1",
			white = mocha.text or "#cdd6f4",
			magenta = mocha.mauve or "#cba6f7",
			blue = mocha.blue or "#89b4fa",
			red = mocha.red or "#f38ba8",
			orange = mocha.peach or "#fab387",
			violet = mocha.mauve or "#cba6f7",
		}

		-- 2. DEFINE CUSTOM THEME
		local shadow_theme = {
			normal = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			insert = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			visual = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			replace = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			command = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			inactive = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
		}

		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = shadow_theme,
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "starter", "snacks_dashboard" },
					winbar = { "dashboard", "alpha", "starter", "snacks_dashboard" },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		-- 1. Left Bar
		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 0, right = 1 },
		})

		-- 2. The Robust Mode Indicator
		ins_left({
			function()
				return ""
			end,
			color = function()
				local mode_color = {
					n = colors.orange, -- Normal
					no = colors.orange,
					nov = colors.orange,
					noV = colors.orange,

					i = colors.violet, -- Insert
					ic = colors.violet,
					ix = colors.violet,

					v = colors.green, -- Visual
					["\22"] = colors.green, -- Visual Block (Ctrl-V)
					V = colors.green, -- Visual Line

					c = colors.magenta, -- Command

					R = colors.red, -- Replace
					Rv = colors.red,

					t = colors.red, -- Terminal
				}
				return { fg = mode_color[vim.fn.mode()] or colors.orange }
			end,
			padding = { right = 1 },
		})

		-- 3. Filename
		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({ "location" })

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		-- Mid Section Spacer
		ins_left({
			function()
				return "%="
			end,
		})

		-- 4. LSP Status
		ins_right({
			function()
				local msg = "No Active Lsp"
				if not vim.lsp.get_clients then
					return msg
				end
				local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
				if #buf_clients == 0 then
					return msg
				end

				local client_names = {}
				for _, client in ipairs(buf_clients) do
					if client.name ~= "null-ls" and client.name ~= "copilot" then
						table.insert(client_names, client.name)
					end
				end

				if #client_names == 0 then
					return msg
				end
				return table.concat(client_names, ", ")
			end,
			icon = " LSP:",
			color = { fg = colors.white, gui = "bold" },
		})

		-- 5. Git Branch
		ins_right({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})

		-- 6. Diff
		ins_right({
			"diff",
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		-- 7. Right Bar
		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		return config
	end,
}
