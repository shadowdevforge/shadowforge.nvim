-- =============================================================================
--  READ ONLY FILE
--  shadowforge/health/doctor.lua
-- =============================================================================
local M = {}

-- =============================================================================
--  1. THE DIAGNOSTIC ENGINE (:ShadowDoctor)
-- =============================================================================

-- Nerd Font Icons
local icons = {
	title = "󰔐 ", -- Thermometer
	ok = " ", -- Check Circle (Green)
	err = " ", -- Times Circle (Red)
	warn = " ", -- Warning (Yellow)
	missing = " ", -- Ban / Missing
	nvim = " ", -- Neovim Logo
	pkg = " ", -- Package
	persist = " ", -- Save/Disk
	network = "󰖟 ", -- Globe/Network
	build = " ", -- Box/Build tool
	code = " ", -- Code tag
}

local requirements = {
	{ tool = "nvim", min_version = "0.9.0" },
	{ tool = "git", required = true, desc = "Version Control", icon = icons.code },
	{ tool = "rg", required = true, desc = "Ripgrep (Telescope Speed)", icon = icons.pkg },
	{ tool = "fd", required = true, desc = "Fd (Finder Speed)", icon = icons.pkg },
	{ tool = "lazygit", required = false, desc = "Git TUI (Snacks)", icon = icons.code },
	{ tool = "node", required = true, desc = "NodeJS (LSP/Mason)", icon = icons.network },
	{ tool = "npm", required = true, desc = "NPM (Package Manager)", icon = icons.pkg },
	{ tool = "gcc", required = true, desc = "GCC (Treesitter Compiler)", icon = icons.build },
	{ tool = "curl", required = true, desc = "Curl (Network)", icon = icons.network },
	{ tool = "make", required = true, desc = "Make (FZF Native Build)", icon = icons.build },
}

function M.doctor()
	local report = {}
	table.insert(report, icons.title .. " SHADOWFORGE DIAGNOSTICS")
	table.insert(report, " ━━━━━━━━━━━━━━━━━━━━━━━━━")
	table.insert(report, "")

	-- 1. Check Neovim Version
	local nvim_ver = vim.version()
	local nvim_ver_str = string.format("%d.%d.%d", nvim_ver.major, nvim_ver.minor, nvim_ver.patch)
	table.insert(report, " " .. icons.nvim .. " Neovim: " .. nvim_ver_str)

	-- 2. Check External Tools
	for _, req in ipairs(requirements) do
		if req.tool ~= "nvim" then
			local installed = vim.fn.executable(req.tool) == 1
			local status_icon = installed and icons.ok or (req.required and icons.err or icons.warn)
			local status_text = installed and "Installed" or "Missing"

			-- Extra check for 'fd' (often named 'fdfind' on Debian/Ubuntu)
			if req.tool == "fd" and not installed then
				if vim.fn.executable("fdfind") == 1 then
					installed = true
					status_icon = icons.ok
					status_text = "Installed (as fdfind)"
				end
			end

			local tool_icon = req.icon or icons.pkg
			table.insert(
				report,
				string.format(" %s %s %-10s : %s (%s)", status_icon, tool_icon, req.tool, status_text, req.desc)
			)
		end
	end

	-- 3. Check Persistence File
	local theme_path = vim.fn.stdpath("data") .. "/shadowforge_theme"
	if vim.fn.filereadable(theme_path) == 1 then
		table.insert(report, " " .. icons.ok .. " " .. icons.persist .. " Persistence : Active")
	else
		table.insert(report, " " .. icons.warn .. " " .. icons.persist .. " Persistence : No theme saved yet")
	end

	-- Display Report using Notify
	local Snacks = package.loaded["snacks"]
	if Snacks and Snacks.notifier then
		Snacks.notify.info(table.concat(report, "\n"), { title = "Doctor", timeout = 10000 })
	else
		vim.notify(table.concat(report, "\n"), vim.log.levels.INFO)
	end
end

-- =============================================================================
--  2. THE UPDATER (:ShadowUpdate)
-- =============================================================================

function M.update()
	local notify = require("snacks").notify

	-- Step 1: Git Pull
	notify.info("🚀 Pulling ShadowForge Core updates...", { title = "ShadowUpdate", id = "update_spin" })

	vim.fn.jobstart({ "git", "pull" }, {
		cwd = vim.fn.stdpath("config"),
		on_exit = function(_, code)
			if code == 0 then
				notify.info(icons.ok .. " Core Updated.", { title = "ShadowUpdate", id = "update_spin" })
			else
				notify.warn(
					icons.warn .. " Git Pull failed (Are you in a git repo?). Skipping to plugins.",
					{ title = "ShadowUpdate", id = "update_spin" }
				)
			end

			-- Step 2: Lazy Sync
			notify.info(icons.pkg .. " Syncing Plugins (Lazy)...", { title = "ShadowUpdate", id = "update_spin" })
			require("lazy").sync({
				wait = true,
				show = false,
			})

			-- Step 3: Mason Update
			notify.info(icons.build .. " Updating Mason Tools...", { title = "ShadowUpdate", id = "update_spin" })
			vim.cmd("MasonUpdate")

			-- Step 4: Treesitter Update
			notify.info(icons.code .. " Updating Treesitter Parsers...", { title = "ShadowUpdate", id = "update_spin" })
			vim.cmd("TSUpdate")

			notify.info(
				"✨ ShadowForge Upgrade Complete! Please restart.",
				{ title = "ShadowUpdate", id = "update_spin" }
			)
		end,
	})
end

function M.setup()
	vim.api.nvim_create_user_command("ShadowDoctor", M.doctor, { desc = "Run ShadowForge diagnostics" })
	vim.api.nvim_create_user_command("ShadowUpdate", M.update, { desc = "Update ShadowForge Core & Plugins" })
end

return M
