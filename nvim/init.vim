:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set expandtab
:set completeopt=menu,menuone,noselect
:set scrolloff=8
:set mouse=

" Increment alphanumeric characters as well
:set nrformats+=alpha

" set <leader> to SpaceBar
let mapleader = " "

" Searching
set ignorecase smartcase
set nohlsearch
set incsearch " incremental search

call plug#begin()

" Common
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" UI stuff
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" lsp kind of stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

" Completion/snippets
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'natecraddock/telescope-zf-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" QOL
Plug 'windwp/nvim-autopairs'
Plug 'ThePrimeagen/harpoon'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Git stuff
Plug 'kdheepak/lazygit.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'f-person/git-blame.nvim'

" VsCode compatibility
Plug 'EthanJWright/vs-tasks.nvim'

" C++ stuff
Plug 'rhysd/vim-clang-format'

call plug#end()

colorscheme gruvbox
" Use terminal background instead
highlight Normal ctermbg=NONE

" Basic overwrites
" Always keep cursor centered when jumping - easier to follow
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Substitute all at cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" Start substitute based on marked visually
vnoremap <Leader>s :s/
" Append to end when using visual mode (useful for multi line)
vnoremap <Leader>e :s/$/

" Substitute one occurence at once:
" Use eg: /search_name <Leader>cgn something_new exit and then hit . to repeat
" Mapping to do the same
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn
