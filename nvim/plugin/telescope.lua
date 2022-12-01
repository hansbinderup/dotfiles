-- Sorter which weighs filename matches higher
require'telescope'.load_extension('zf-native')

-- Enable the file_browser extension
require'telescope'.load_extension('file_browser')

-- When the floating view is not wide enough, truncate the paths
require'telescope'.setup {
    defaults={
        path_display={
            "truncate"
        },
        dynamic_preview_title=true
    },
    extensions={
        file_browser={
            hijack_netrw=true,
            dir_icon="🖿",
            hidden=true,
            grouped=true
        }
    }
}


require('telescope').load_extension('dap')

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true}

-- Some search bindings for global searches without filters
vim.api.nvim_set_keymap('n', '<Leader>ff', ":lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-uu' } }<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fF', ":lua require'telescope.builtin'.grep_string{ vimgrep_arguments = { 'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-uu' } }<CR>", {noremap = true, silent = true})
