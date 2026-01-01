return {
    {
        "rhysd/vim-clang-format",
        lazy = false,
        config = function()
            -- Enable auto format for clangd based on filetypes
            vim.cmd('autocmd FileType c,cpp,h,hpp ClangFormatAutoEnable')
        end
    },
}
