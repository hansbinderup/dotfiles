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

" set <leader> to SpaceBar
let mapleader = " "

" Searching
set ignorecase smartcase
set hlsearch
set incsearch " incremental search

call plug#begin()

" Common
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" UI stuff
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'nvim-lualine/lualine.nvim'

" lsp kind of stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate :TSInstall jsonc'}
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
Plug 'natecraddock/telescope-zf-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" QOL
Plug 'windwp/nvim-autopairs'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Git stuff
Plug 'kdheepak/lazygit.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

" VsCode compatibility
Plug 'EthanJWright/vs-tasks.nvim'

" C++ stuff
Plug 'rhysd/vim-clang-format'
Plug 'octol/vim-cpp-enhanced-highlight'

" Debugging 
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

call plug#end()

colorscheme gruvbox

