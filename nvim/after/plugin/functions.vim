fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
endfun

function! TelescopeLiveGrep()
    lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown(git_files))
endfunction

" Custom cmd to use `git_files()` when available, fallback to `find_files()`
command TeleScopeProjectFiles
\       :lua
\       local ok = pcall(require'telescope.builtin'.git_files)
\       if not ok then require'telescope.builtin'.find_files() end


nnoremap <leader>fg :call TelescopeLiveGrep()<cr>
nnoremap <leader>pf :TeleScopeProjectFiles<Cr>
