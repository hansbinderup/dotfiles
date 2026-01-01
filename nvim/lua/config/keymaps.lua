-- =========================
--  Key mappings
-- =========================

local map = vim.keymap.set

-- Always keep cursor centered when jumping
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Copy to clipboard
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>y", '"+y')

-- Paste from clipboard
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')

-- Substitute all at cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/]])

-- Start substitute based on visual selection
map("v", "<leader>s", ":s/")

-- Append to end when using visual mode
map("v", "<leader>e", ":s/$/")

-- Substitute one occurrence at a time (cgn helper)
map(
  "n",
  "c<Tab>",
  [[:let @/=expand('<cword>')<CR>cgn]],
  { silent = true }
)

-- Terminal: escape to normal mode
map("t", "<C-q>", [[<C-\><C-n>]])

-- Disable PageUp / PageDown (Nordic keyboard sanity)
map({ "n", "i", "v" }, "<PageUp>", "<Nop>")
map({ "n", "i", "v" }, "<PageDown>", "<Nop>")
