-- =============================================================================
--  SHADOWFORGE PLUGIN OVERRIDES
--  "Extend the Forge without breaking the Core"
-- =============================================================================
--
--  This file allows you to:
--  1. Add completely new plugins.
--  2. Modify existing plugins (add flags, change themes, add languages).
--  3. Disable core plugins you don't use.
--
--  Powered by Lazy.nvim's inheritance system.

return {

	-- ---------------------------------------------------------------------------
	--  SECTION 1: ADDING NEW PLUGINS
	-- ---------------------------------------------------------------------------

	-- Example: Add GitHub Copilot
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   event = "InsertEnter",
	--   opts = {
	--     suggestion = {
	--       enabled = true,
	--       auto_trigger = true,
	--       keymap = {
	--         accept = "<C-l>", -- Ctrl+l to accept suggestion
	--       },
	--     },
	--   },
	-- },

	-- Example: Add a fun plugin (Cellular Automaton)
	-- {
	--   "eandrju/cellular-automaton.nvim",
	--   keys = {
	--     { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Code Rain" },
	--   },
	-- },

	-- ---------------------------------------------------------------------------
	--  SECTION 2: MODIFYING CORE PLUGINS
	-- ---------------------------------------------------------------------------

	-- Example: Add specific languages to Treesitter
	-- You don't need to redefine the whole config, just append to ensure_installed.
	-- {
	--   "nvim-treesitter/nvim-treesitter",
	--   opts = function(_, opts)
	--     if type(opts.ensure_installed) == "table" then
	--       vim.list_extend(opts.ensure_installed, {
	--         "elixir",
	--         "heex",
	--         "vue",
	--         "sql",
	--       })
	--     end
	--   end,
	-- },

	-- Example: Customize Mason to install extra linters/debuggers
	-- {
	--   "williamboman/mason.nvim",
	--   opts = {
	--     ensure_installed = {
	--       "stylua",
	--       "shellcheck",
	--       "shfmt",
	--       "black",
	--       "eslint_d",
	--     },
	--   },
	-- },

	-- Example: Change Neo-tree width
	-- {
	--   "nvim-neo-tree/neo-tree.nvim",
	--   opts = {
	--     window = {
	--       width = 40, -- Make it wider
	--     },
	--   },
	-- },

	-- ---------------------------------------------------------------------------
	--  SECTION 3: DISABLING PLUGINS
	-- ---------------------------------------------------------------------------

	-- Example: Disable Flash.nvim if you don't like jump motions
	-- {
	--   "folke/flash.nvim",
	--   enabled = false,
	-- },

	-- Example: Disable Noice (if you prefer standard cmdline)
	-- {
	--   "folke/noice.nvim",
	--   enabled = false,
	-- },
}
