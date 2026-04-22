return {
    {
        "morhetz/gruvbox",
        commit = "697c00291db857ca0af00ec154e5bd514a79191f",
        enabled = true,
        lazy = false,
        config = function()
            -- Use terminal background instead
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
            vim.cmd.colorscheme("gruvbox")
        end
    }
}

