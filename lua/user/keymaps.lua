-- =============================================================================
--  SHADOWFORGE USER KEYMAPS
--  "Your Workflow, Your Rules"
-- =============================================================================

-- Shorten function name
local map = vim.keymap.set
-- Default options: Noremap (non-recursive), Silent (no message area noise)
local opts = { noremap = true, silent = true }

-- Helper to merge opts with description
local function desc(d)
  return vim.tbl_extend("force", opts, { desc = d })
end

-- -----------------------------------------------------------------------------
--  SECTION 1: EDITOR UTILITIES
-- -----------------------------------------------------------------------------

-- Example: Toggle Word Wrap
-- map("n", "<leader>uw", "<cmd>set wrap!<cr>", desc("Toggle Wrap"))

-- Example: Press 'jk' fast to exit insert mode (Alternative to core 'jj')
-- map("i", "jk", "<Esc>", desc("Fast Escape"))

-- Example: Select all text in buffer
-- map("n", "<C-a>", "gg<S-v>G", desc("Select All"))

-- Example: Yank to system clipboard explicitly (if not using unnamedplus)
-- map({ "n", "v" }, "<leader>y", [["+y]], desc("Yank to Clipboard"))

-- -----------------------------------------------------------------------------
--  SECTION 2: CUSTOM PLUGIN MAPS
-- -----------------------------------------------------------------------------

-- Example: Quick access to Mason
-- map("n", "<leader>pm", "<cmd>Mason<cr>", desc("Mason Installer"))

-- Example: Search specific directories with Telescope
-- map("n", "<leader>fc", function()
--   require("telescope.builtin").find_files({ cwd = "~/.config/shadowforge.nvim" })
-- end, desc("Find Config Files"))

-- -----------------------------------------------------------------------------
--  SECTION 3: WINDOW & BUFFER MANAGEMENT
-- -----------------------------------------------------------------------------

-- Example: Split window vertically and focus
-- map("n", "<leader>|", "<cmd>vsplit<cr>", desc("Vertical Split"))

-- Example: Split window horizontally and focus
-- map("n", "<leader>-", "<cmd>split<cr>", desc("Horizontal Split"))

-- -----------------------------------------------------------------------------
--  SECTION 4: TERMINAL (If using toggleterm or snacks terminal)
-- -----------------------------------------------------------------------------

-- Example: Map Ctrl+t to toggle floating terminal
-- map({ "n", "t" }, "<C-t>", function()
--   require("snacks").terminal()
-- end, desc("Toggle Terminal"))
