-- Sorter which weighs filename matches higher
require'telescope'.load_extension('zf-native')

-- Enable the file_browser extension
require'telescope'.load_extension('file_browser')

-- Enable file grepping with ripgrep args
-- https://jdhao.github.io/2020/02/16/ripgrep_cheat_sheet/
require("telescope").load_extension("live_grep_args")

-- Use telescope extension for harpoon
require("telescope").load_extension('harpoon')

-- Disable preview for big files
local previewers = require('telescope.previewers')
local ignore_big_files_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 500000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end


-- When the floating view is not wide enough, truncate the paths
require'telescope'.setup {
    defaults={
        mappings = {
            n = {
                ['<c-b>'] = require('telescope.actions').delete_buffer
            },
            i = {
                ["<C-h>"] = "which_key",
                ['<c-b>'] = require('telescope.actions').delete_buffer
            },
        },
        buffer_previewer_maker = ignore_big_files_maker,
        path_display = {
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

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true}

-- Some search bindings for global searches without filters
vim.api.nvim_set_keymap('n', '<Leader>fF', ":lua require'telescope.builtin'.grep_string{ vimgrep_arguments = { 'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-uu' } }<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ff', ":lua require('telescope').extensions.live_grep_args.live_grep_args{ vimgrep_arguments = { 'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-uu' } }<CR>", {noremap = true, silent = true})
