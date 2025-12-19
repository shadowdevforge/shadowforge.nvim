-- =============================================================================
--  READ ONLY FILE
--  shadowforge/core/keymaps.lua
-- =============================================================================
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =============================================================================
--  GENERAL & SAFETY
-- =============================================================================

-- 1. SAVE: Leader + w
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- 2. ESCAPE: 'jj' in insert mode
map("i", "jj", "<Esc>", { desc = "Fast Escape" })

-- 3. COMMAND MODE: Swap ; and :
map("n", ";", ":", { desc = "Enter Command Mode" })
map("v", ";", ":", { desc = "Enter Command Mode" })
map("n", ":", ";", { desc = "Repeat Find Char" })
map("v", ":", ";", { desc = "Repeat Find Char" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit Quickly" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev Diagnostic" })

-- =============================================================================
--  NAVIGATION (Centered)
-- =============================================================================

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- =============================================================================
--  WINDOW MANAGEMENT
-- =============================================================================

map("n", "<C-h>", "<C-w>h", { desc = "Go Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go Right Window" })

-- Resize
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- =============================================================================
--  BUFFER MANAGEMENT
-- =============================================================================

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close Buffer" })

-- =============================================================================
--  TEXT MANIPULATION
-- =============================================================================

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Line Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Line Up" })

-- Indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- No-loss Paste
map("x", "p", [["_dP]])
