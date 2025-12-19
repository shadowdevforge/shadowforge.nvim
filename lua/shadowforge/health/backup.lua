local M = {}

function M.backup()
	local notify = require("snacks").notify
	local config_path = vim.fn.stdpath("config")
	local user_path = config_path .. "/lua/user"

	-- 1. Generate Timestamp
	local timestamp = os.date("%Y-%m-%d-%H-%M-%S")
	local snapshot_name = "snapshot-" .. timestamp
	local snapshot_dir = user_path .. "/snapshots/" .. snapshot_name

	-- 2. Create Snapshots Directory if not exists
	if vim.fn.isdirectory(user_path .. "/snapshots") == 0 then
		vim.fn.mkdir(user_path .. "/snapshots", "p")
	end

	-- 3. Create the specific snapshot folder
	vim.fn.mkdir(snapshot_dir, "p")

	-- 4. Notify Start
	notify.info("  Creating system snapshot...", { title = "ShadowBackup", id = "backup_spin" })

	-- 5. Copy Files (Safe Loop)
	-- We explicitly scan for .lua files in lua/user to avoid copying the 'snapshots' folder recursively
	local files = vim.split(vim.fn.glob(user_path .. "/*.lua"), "\n", { trimempty = true })

	local count = 0
	for _, file in ipairs(files) do
		local filename = vim.fn.fnamemodify(file, ":t")
		local dest = snapshot_dir .. "/" .. filename

		-- Copy logic (Platform agnostic-ish)
		local content = vim.fn.readfile(file)
		vim.fn.writefile(content, dest)
		count = count + 1
	end

	-- 6. Success Report
	if count > 0 then
		notify.info(
			string.format("  Snapshot Created!\n📂 %s\n📄 %d files backed up.", snapshot_name, count),
			{ title = "ShadowBackup", id = "backup_spin" }
		)
	else
		notify.warn("  No user config files found to backup.", { title = "ShadowBackup", id = "backup_spin" })
	end
end

function M.setup()
	vim.api.nvim_create_user_command("ShadowBackup", M.backup, { desc = "Create a snapshot of user config" })
end

return M
