-- =========================
--  Basic options
-- =========================

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.scrolloff = 8
vim.opt.mouse = "" -- disable mouse
vim.opt.nrformats:append("alpha")

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

