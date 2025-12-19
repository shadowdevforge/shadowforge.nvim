-- =============================================================================
--  READ ONLY FILE
--  shadowforge/core/autocmds.lua
-- =============================================================================
local function augroup(name)
	return vim.api.nvim_create_augroup("shadowforge_" .. name, { clear = true })
end

-- 1. Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- 2. Resize windows when terminal is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- 3. THEME PERSISTENCE
-- Saves the theme name to a file whenever :colorscheme runs
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("save_theme"),
	callback = function()
		local theme = vim.g.colors_name
		if theme then
			local path = vim.fn.stdpath("data") .. "/shadowforge_theme"
			local file = io.open(path, "w")
			if file then
				file:write(theme)
				file:close()
			end
		end
	end,
})

-- 4. Close some buffers with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"checkhealth",
		"themery",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- 5. CORE FILE PROTECTION (The Guard)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("core_protection"),
	pattern = "*",
	callback = function(event)
		local file = vim.fn.expand("%:p")
		local config_path = vim.fn.stdpath("config")

		-- Normalize paths for Windows/Linux compatibility
		file = file:gsub("\\", "/")
		config_path = config_path:gsub("\\", "/")

		-- Only trigger if we are editing inside the ShadowForge Config directory
		if not string.find(file, config_path, 1, true) then
			return
		end

		-- Allow editing the User directory (This is the Safe Zone)
		if string.find(file, "/lua/user/", 1, true) then
			return
		end

		-- Allow editing the lockfile (updates write to this)
		if string.find(file, "lazy%-lock.json") then
			return
		end

		-- If we are here, the user is touching Core files (init.lua or lua/shadowforge/*)
		local Snacks = package.loaded["snacks"]
		if Snacks and Snacks.notifier then
			Snacks.notify.warn(
				"  This is a READ ONLY file!\nIf you've broke something, run :ShadowUpdate",
				{ title = "Core Protection", timeout = 5000 }
			)
		else
			vim.notify(
				" This is a READ ONLY file! If you've broke something, run :ShadowUpdate",
				vim.log.levels.WARN
			)
		end
	end,
})
