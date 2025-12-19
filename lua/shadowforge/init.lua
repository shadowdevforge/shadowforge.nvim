-- =============================================================================
--  READ ONLY FILE
--  shadowforge/init.lua
-- =============================================================================
local M = {}

function M.setup()
	-- 1. LOAD CONFIG ENGINE
	-- This reads lua/user/init.lua and prepares the global settings
	local config = require("shadowforge.config").setup()

	-- 2. Load Basic Options (Refactored to use config)
	require("shadowforge.core.options")

	-- 3. Load Core Keymaps
	require("shadowforge.core.keymaps")

	-- 4. Initialize Lazy.nvim
	require("lazy").setup({
		spec = {
			{ import = "shadowforge.modules.ui" },
			{ import = "shadowforge.modules.editor" },
			{ import = "shadowforge.modules.coding" },
			{ import = "shadowforge.modules.lsp" },
			{ import = "shadowforge.modules.treesitter" },
			{ import = "user.overrides" },
		},
		-- ... (rest of lazy config)
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

	-- 5. Load Autocmds
	require("shadowforge.core.autocmds")

	-- 6. Load User Keymaps
	pcall(require, "user.keymaps")

	-- 7. Load Doctor
	require("shadowforge.health.doctor").setup()
end

M.setup()

return M
