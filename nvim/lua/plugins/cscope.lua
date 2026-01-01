return {
    {
        'dhananjaylatkar/cscope_maps.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        lazy = false,
        config = function()
            require("cscope_maps").setup {
                skip_input_prompt = true,
                cscope = {
                    picker = "telescope",
                    skip_picker_for_single_result = true,
                }
            }
        end
    }
}
