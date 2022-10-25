require("vstask").setup({
  cache_strategy = "last", -- can be "most" or "last" (most used / last used)
  use_harpoon = false, -- use harpoon to auto cache terminals
  telescope_keys = { -- change the telescope bindings used to launch tasks
      horizontal = '<C-h>',
	  vertical = '<C-v>',
      split = '<CR>',
      tab = '<C-t>',
      current = '<C-c>',
  },
  term_opts = {
	terminal = "floaterm",
	vertical = {
      direction = "vertical",
      size = "80"
    },
    horizontal = {
      direction = "horizontal",
      size = "15"
    },
    current = {
      direction = "float",
    },
    tab = {
      direction = 'tab',
    }
  }
})
