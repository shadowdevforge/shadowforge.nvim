-- =============================================================================
--  READ ONLY FILE
--  nvim/init.lua
-- =============================================================================
-- 1. Global Performance Optimizations
vim.loader.enable()

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- 2. BOOTSTRAP LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Define the Setup Logic
local M = {}

function M.setup()
	-- A. LOAD CONFIG ENGINE
	local config_status, config = pcall(require, "shadowforge.config")
	if config_status then
		config.setup()
	end

	-- B. Load Core Settings
	require("shadowforge.core.options")
	require("shadowforge.core.keymaps")

	-- C. Initialize Lazy.nvim
	require("lazy").setup({
		spec = {
			{ import = "shadowforge.modules.ui" },
			{ import = "shadowforge.modules.editor" },
			{ import = "shadowforge.modules.coding" },
			{ import = "shadowforge.modules.lsp" },
			{ import = "shadowforge.modules.treesitter" },
			{ import = "user.overrides" },
		},
		defaults = { lazy = true, version = false },
		checker = { enabled = true, notify = false },
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
		ui = { border = "rounded", backdrop = 100 },
	})

	-- D. Load Runtime Logic
	require("shadowforge.core.autocmds")
	pcall(require, "user.keymaps")
	require("shadowforge.health.doctor").setup()
	require("shadowforge.health.backup").setup()
end

M.setup()
