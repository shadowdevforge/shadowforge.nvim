-- =============================================================================
--  READ ONLY FILE
--  shadowforge/config.lua
-- =============================================================================
local M = {}

-- 1. THE DEFAULTS (Safe Fallbacks)
M.defaults = {
	-- General Editor Settings
	editor = {
		relative_numbers = true, -- line numbers
		wrap = false, -- text wrapping
		scrolloff = 8, -- lines of context
		tab_width = 2, -- indentation size
	},

	-- Visuals
	ui = {
		transparency = false, -- Global transparency toggle
		animations = true, -- Window animations
		border = "rounded", -- none, single, double, rounded, solid
	},

	-- Intelligence
	lsp = {
		-- Servers to auto-install via Mason
		servers = {
			"lua_ls",
			"ts_ls",
			"pyright",
			"html",
			"cssls",
			"jsonls",
			"bashls",
		},
		-- Formatting options
		formatting = {
			format_on_save = true,
			timeout_ms = 1000,
		},
	},
}

-- 2. THE MERGE LOGIC
M.options = {}

function M.setup()
	-- Try to load user config
	local user_config_status, user_config = pcall(require, "user")
	if not user_config_status or type(user_config) ~= "table" then
		user_config = {}
	end

	-- Deep merge defaults with user config
	M.options = vim.tbl_deep_extend("force", M.defaults, user_config)

	return M.options
end

return M
