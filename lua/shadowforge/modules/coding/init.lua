-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/coding/init.lua
-- =============================================================================

return {
	-- 1. BLINK.CMP
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			completion = {
				ghost_text = { enabled = false },
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				menu = { auto_show = true },
			},

			signature = { enabled = true },
		},
		config = function(_, opts)
			local blink = require("blink.cmp")

			-- 1. Apply Config
			blink.setup(opts)

			-- 2. Force "0.5 Opacity" look by linking to Comment highlight
			-- We use an autocmd to ensure this persists even if the theme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
				end,
			})
			-- Apply immediately
			vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })

			-- 3. Toggle Keymap (<leader>gt)
			vim.keymap.set("n", "<leader>gt", function()
				-- Toggle state
				opts.completion.ghost_text.enabled = not opts.completion.ghost_text.enabled

				-- Reload Blink with new settings
				blink.setup(opts)

				-- Notify User
				local state = opts.completion.ghost_text.enabled and "Enabled" or "Disabled"
				local Snacks = package.loaded["snacks"]
				if Snacks then
					Snacks.notify.info("Ghost Text: " .. state, { title = "Blink CMP" })
				else
					vim.notify("Ghost Text: " .. state, vim.log.levels.INFO)
				end
			end, { desc = "Toggle Ghost Text" })
		end,
	},

	-- 2. AUTO PAIRS
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },

	-- 3. SURROUND
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete Surrounding" },
				{ opts.mappings.find, desc = "Find Right Surrounding" },
				{ opts.mappings.find_left, desc = "Find Left Surrounding" },
				{ opts.mappings.highlight, desc = "Highlight Surrounding" },
				{ opts.mappings.replace, desc = "Replace Surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update Surrounding Lines" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},

	-- 4. FORMATTING (Conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = function()
			-- DYNAMIC CONFIG LOADING
			local settings = require("shadowforge.config").options.lsp.formatting

			return {
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
				},
				-- Toggle based on user config
				format_on_save = settings.format_on_save and {
					timeout_ms = settings.timeout_ms,
					lsp_fallback = true,
				} or nil,
			}
		end,
	},
}
