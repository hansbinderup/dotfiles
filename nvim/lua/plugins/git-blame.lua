return {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        enabled = true,
        message_template = " <summary> • <author> • <date>",
        date_format = "%d/%m-%Y %H:%M",
        virtual_text_column = 1,
    },
 
}
