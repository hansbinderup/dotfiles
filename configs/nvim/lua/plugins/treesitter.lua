return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "master",
        lazy = false, -- not supported!
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"c", "cpp", "lua", "bash"},
                sync_install = false,
                highlight = {
                    enable = true,
                    disable = function(lang, bufnr) -- Disable in large buffers
                        return vim.api.nvim_buf_line_count(bufnr) > 5000
                    end,
                    additional_vim_regex_highlighting = true
                },
                indent = {
                    enable = true,
                },
                autopairs = {
                    enable = true
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false
                },
                playground = {
                    enable = false
                },
            }
        end
    }
}
