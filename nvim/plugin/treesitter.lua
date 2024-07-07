 local status_ok, treesitter = pcall(require, "nvim-treesitter")
 if not status_ok then
 	return
 end

 local status_ok, configs = pcall(require, "nvim-treesitter.configs")
 if not status_ok then
     vim.notify("Error loading nvim-treesitter.configs")
     return
 end

 configs.setup {
     ensure_installed = {"c", "cpp", "lua", "bash"},
     sync_install = false,
     ignore_install = {}, -- List of parsers to ignore installing
     highlight = {
         enable = true,
         disable = function(lang, bufnr) -- Disable in large C++ buffers
             return lang == "cpp" and api.nvim_buf_line_count(bufnr) > 5000
         end,
         disable = { "" }, -- list of language that will be disabled
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
         enable = true
     },
 }

