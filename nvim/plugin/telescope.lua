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

-- Custom cmd to use `git_files()` when available, fallback to `find_files()`
-- vim.cmd('command TeleScopeProjectFiles
-- \       :lua
-- \       local ok = pcall(require'telescope.builtin'.git_files)
-- \       if not ok then require'telescope.builtin'.find_files() end')
