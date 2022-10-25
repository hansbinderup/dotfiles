" Project Search
nnoremap <leader>fS :lua require'telescope.builtin'.grep_string()<Cr>
nnoremap <leader>fs :lua require'telescope.builtin'.grep_string({
                        \search = vim.fn.input("search> ")})<Cr>
" Project files
nnoremap <leader>pf :TeleScopeProjectFiles<Cr>
nnoremap <C-p> <cmd>Telescope find_files<Cr>
nnoremap <leader>fb :Telescope file_browser path=%:p:h<Cr>

" Show buffers
nnoremap <leader>bs :lua require'telescope.builtin'.buffers()<Cr>

" Show hidden files
nnoremap <leader>geh <cmd>Telescope find_files hidden=true<cr>

" Git commands
nnoremap <leader>gs :lua require'telescope.builtin'.git_status()<Cr>
nnoremap <leader>gc :lua require'telescope.builtin'.git_bcommits()<Cr>
nnoremap <leader>gac :lua require'telescope.builtin'.git_commits()<Cr>
nnoremap <leader>gb :lua require'telescope.builtin'.git_branches()<Cr>

" LSP commands
nnoremap <leader>cd :lua require'telescope.builtin'.lsp_definitions()<Cr>
nnoremap <leader>ci :lua require'telescope.builtin'.lsp_implementations()<Cr>
nnoremap <leader>cr :lua require'telescope.builtin'.lsp_references({path_display=function(opts, path) local tail = require('telescope.utils').path_tail(path) local rel = require('plenary.path'):new(path):make_relative(vim.loop.cwd()) local start = string.match(rel, "(.-)/") return string.format("%s \| %s", start, tail) end,layout_strategy='vertical',layout_config={width=0.95},fname_width=60,trim_text=true})<Cr>
nnoremap <leader>ch :lua vim.lsp.buf.signature_help()<Cr>

" Clangd commands
nnoremap <A-o> :ClangdSwitchSourceHeader<Cr>

" Terminal (floaterm) commands
nnoremap <C-S-t> :call OpenTerminal()<Cr>
nnoremap <C-t> :FloatermToggle<Cr>

" Remap ESC to leave --- TERMINAL MODE ---
tnoremap <Esc> <C-\><C-n>
" Switch windows 'normally' while in --- TERMINAL MODE ---
tnoremap <C-w> <C-\><C-N><C-w>

" VScode tasks
nnoremap <Leader>ta :lua require("telescope").extensions.vstask.tasks()<CR>
nnoremap <Leader>ti :lua require("telescope").extensions.vstask.inputs()<CR>
nnoremap <Leader>th :lua require("telescope").extensions.vstask.history()<CR>
nnoremap <Leader>tl :lua require('telescope').extensions.vstask.launch()<cr>

" Git diff view
nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gdc :DiffviewClose<CR>
