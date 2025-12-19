-- =============================================================================
--  SHADOWFORGE USER CONFIGURATION
--  "The Easiest Config System"
-- =============================================================================

return {
	-- 1. EDITOR SETTINGS
	editor = {
		relative_numbers = true, -- Set to false for standard numbers
		wrap = false, -- Set to true to wrap long lines
		tab_width = 2, -- Space width for indentation
	},

	-- 2. VISUALS
	ui = {
		transparency = false, -- Set to true for transparent background
		animations = true, -- Enable/Disable window tinting & animations
	},

	-- 3. INTELLIGENCE & TOOLS
	lsp = {
		-- Add the languages you want Mason to install automatically
		-- Examples: "rust_analyzer", "gopls", "clangd", "tailwindcss"
		servers = {
			-- "lua_ls",
			-- "ts_ls",
			-- "pyright",
			-- "html",
			-- "cssls",
			-- "jsonls",
			-- "bashls",
			-- Add more here!
		},

		-- Formatting Behavior
		formatting = {
			format_on_save = true, -- Auto-format on :w
		},
	},
}
