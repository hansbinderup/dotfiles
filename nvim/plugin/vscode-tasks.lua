require("vstask").setup({
    cache_strategy = "last", -- can be "most" or "last" (most used / last used)
    use_harpoon = false, -- use harpoon to auto cache terminals
    telescope_keys = { -- change the telescope bindings used to launch tasks
        horizontal = '<C-t>',
        vertical = '<C-v>',
        split = '<C-s>',
        tab = '<CR>',
        current = '<C-c>',
    },
    ignore_input_default = false,
    terminal = 'nvim',
    term_opts = {
        vertical = {
            direction = "vertical",
            size = "20"
        },
        horizontal = {
            direction = "horizontal",
            size = "20"
        },
        current = {
            direction = "float",
        },
        tab = {
            direction = 'tab',
        },
    }
})
