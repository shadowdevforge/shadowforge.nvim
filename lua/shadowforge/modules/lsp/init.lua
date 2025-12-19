-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/lsp/init.lua
-- =============================================================================
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	-- 2. LSP CONFIG
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- LOAD USER CONFIG
			local config = require("shadowforge.config").options

			-- A. Setup Mason
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- B. Capability Injection (Blink)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- C. Setup Mason-LSPConfig
			require("mason-lspconfig").setup({
				ensure_installed = config.lsp.servers,
				automatic_installation = true,

				-- HANDLERS: simpler and cleaner
				handlers = {
					-- The Default Handler (Runs for every server, including lua_ls)
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			-- D. Keymaps (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local map = vim.keymap.set
					map("n", "gD", vim.lsp.buf.declaration, opts)
					map("n", "gd", vim.lsp.buf.definition, opts)
					map("n", "K", vim.lsp.buf.hover, opts)
					map("n", "gi", vim.lsp.buf.implementation, opts)
					map("n", "<leader>cr", vim.lsp.buf.rename, opts)
					map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					map("n", "gr", vim.lsp.buf.references, opts)
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
				end,
			})

			-- E. Prettify Diagnostics Icons
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},
}
