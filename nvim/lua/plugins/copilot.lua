return {
    'github/copilot.vim',
    lazy = false,

    config = function()
        local map = vim.keymap.set
        local silent = { silent = true }

        map("i", "<C-a>", "<Plug>(copilot-accept-word)", silent)
        map("i", "<C-c>", "<Plug>(copilot-accept-line)", silent)
        map("i", "<C-z>", "<Plug>(copilot-next)", silent)
        map("i", "<C-x>", "<Plug>(copilot-previous)", silent)
    end,
}
