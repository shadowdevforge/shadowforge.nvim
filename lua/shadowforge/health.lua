-- =============================================================================
--  READ ONLY FILE
--  shadowforge/health.lua
-- =============================================================================
local M = {}

-- Use vim.health
local health = vim.health
local start = health.start or health.report_start
local ok = health.ok or health.report_ok
local warn = health.warn or health.report_warn
local error = health.error or health.report_error
local info = health.info or health.report_info

local requirements = {
	{ tool = "git", required = true, desc = "Version Control" },
	{ tool = "rg", required = true, desc = "Ripgrep (Telescope Speed)" },
	{ tool = "fd", required = true, desc = "Fd (Finder Speed)" },
	{ tool = "lazygit", required = false, desc = "Git TUI" },
	{ tool = "node", required = true, desc = "NodeJS (Mason/LSP)" },
	{ tool = "npm", required = true, desc = "NPM (Package Manager)" },
	{ tool = "gcc", required = true, desc = "GCC (Treesitter Compiler)" },
	{ tool = "make", required = true, desc = "Make (FZF Native Build)" },
	{ tool = "curl", required = true, desc = "Curl (Network)" },
}

function M.check()
	-- 1. SYSTEM ENVIRONMENT
	start("System Environment")

	-- Check Neovim Version
	local ver = vim.version()
	local ver_str = string.format("%d.%d.%d", ver.major, ver.minor, ver.patch)
	if ver.major > 0 or (ver.major == 0 and ver.minor >= 10) then
		ok("Neovim Version: " .. ver_str)
	else
		error("Neovim Version: " .. ver_str .. " (Requires >= 0.10.0)")
	end

	-- Check OS
	local os_name = vim.loop.os_uname().sysname
	info("Operating System: " .. os_name)

	-- 2. EXTERNAL TOOLS
	start("External Dependencies")

	for _, req in ipairs(requirements) do
		if vim.fn.executable(req.tool) == 1 then
			-- Get version if possible (simple check)
			local version = vim.fn.trim(vim.fn.system(req.tool .. " --version"):match("[^\n]*"))
			-- If version string is too long or messy, just say installed
			if #version > 50 or version == "" then
				version = "Installed"
			end
			ok(string.format("%s: Found (%s)", req.tool, req.desc))
		else
			if req.required then
				error(string.format("%s: Missing (%s)", req.tool, req.desc))
			else
				warn(string.format("%s: Missing (%s) - Optional", req.tool, req.desc))
			end
		end
	end

	-- 3. CONFIGURATION INTEGRITY
	start("ShadowForge Configuration")

	local config_path = vim.fn.stdpath("config")
	local user_config = config_path .. "/lua/user/init.lua"

	if vim.fn.filereadable(user_config) == 1 then
		ok("User Config found: lua/user/init.lua")
	else
		warn("User Config missing: lua/user/init.lua (Using defaults)")
	end

	-- Check Persistence
	local theme_path = vim.fn.stdpath("data") .. "/shadowforge_theme"
	if vim.fn.filereadable(theme_path) == 1 then
		ok("Theme Persistence: Active")
	else
		warn("Theme Persistence: No state saved yet (Run :colorscheme or <Space>th)")
	end

	-- 4. PERFORMANCE CHECKS
	start("Performance Optimization")

	if vim.loader.enabled then
		ok("Byte-compilation (vim.loader): Enabled")
	else
		warn("Byte-compilation (vim.loader): Disabled (Slow startup)")
	end

	local provider_ruby = vim.g.loaded_ruby_provider
	if provider_ruby == 0 then
		ok("Ruby Provider: Disabled (Optimized)")
	else
		warn("Ruby Provider: Enabled (May slow down startup if not used)")
	end
end

return M
