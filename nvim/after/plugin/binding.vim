" Project Search
nnoremap <leader>fS :lua require'telescope.builtin'.grep_string()<Cr>
nnoremap <leader>fs :Telescope live_grep_args<Cr>

" Project files
nnoremap <C-p> <cmd>Telescope find_files<Cr>
nnoremap <leader>fb :Telescope file_browser path=%:p:h<Cr>

" Show buffers
nnoremap <leader>bs :lua require'telescope.builtin'.buffers()<Cr>

" Show hidden files
nnoremap <leader>geh <cmd>Telescope find_files hidden=true no_ignore=true<cr>

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
nnoremap <leader>ref :lua require'telescope.builtin'.lsp_references()<Cr>

" Clangd commands
nnoremap <A-o> :ClangdSwitchSourceHeader<Cr>

" Commentary
nnoremap <C-k> :Commentary<CR>
vnoremap <C-k> :Commentary<CR>

" Blamer
nnoremap <C-b> :GitBlameToggle<CR>

" Harpoon
nnoremap <Leader>gh :Telescope harpoon marks<CR>
nnoremap <C-ø> :lua require("harpoon.ui").nav_next()<CR>
nnoremap <C-æ> :lua require("harpoon.ui").nav_prev()<CR>
nnoremap <Leader>ga :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>gr :lua require("harpoon.mark").rm_file()<CR>
