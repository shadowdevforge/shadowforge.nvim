-- =============================================================================
--  READ ONLY FILE
--  shadowforge/core/options.lua
-- =============================================================================
local config = require("shadowforge.config").options.editor

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- User Configured Options
vim.opt.number = true
vim.opt.relativenumber = config.relative_numbers
vim.opt.wrap = config.wrap
vim.opt.tabstop = config.tab_width
vim.opt.shiftwidth = config.tab_width
vim.opt.scrolloff = config.scrolloff

-- Standard Defaults
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.undofile = true
