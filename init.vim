""" Jakob's Neovim init.vim
" PLUGINS ------------------------------------------ {{{
call plug#begin(stdpath('config') . '/plugged')

" Aesthetics - Status Line
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'

" Aesthetics - Additional
" Fancy Startpage for vim
Plug 'mhinz/vim-startify'
"color name highlighter
Plug 'ap/vim-css-color'

" COLORSCHEMES
Plug 'rafi/awesome-vim-colorschemes'
Plug 'joshdick/onedark.vim'

" Git Plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Vim Terminal
Plug 'tc50cal/vim-terminal'

" NERDTREE plugin for easier file browsing
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" CODE STUFF
" Comment stuff out with gcc
Plug 'tpope/vim-commentary'
" Surround stuff with ys
Plug 'tpope/vim-surround'
" Auto pair the brackets
Plug 'jiangmiao/auto-pairs'
" Plug 'vim-scripts/auto-pairs-gentle'
" Rainbow brackets
Plug 'frazrepo/vim-rainbow'
" Better code highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Easymotion plug
" Plug 'easymotion/vim-easymotion'
Plug 'phaazon/hop.nvim'
" Make Easymotion work with dot repeat
Plug 'tpope/vim-repeat'

" Better registers
Plug 'junegunn/vim-peekaboo'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Completion (requires some more setup)
Plug 'preservim/tagbar' " Add a tagbar to neovim (Toggle with F8)

"Minimap
" Plug 'wfxr/minimap.vim'

" Fuzzy search with Telescope
Plug 'nvim-lua/plenary.nvim' " required dependency
Plug 'nvim-telescope/telescope.nvim'

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" Board plugin to take some quick notes (still kinda untested)
" Plug 'azabiong/vim-board'
" Vimwiki
Plug 'vimwiki/vimwiki'

call plug#end()
" }}}

" SETTINGS ----------------------------------------- {{{
set termguicolors
set number relativenumber
filetype plugin indent on
syntax on

set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set expandtab
set linebreak

set splitbelow
set splitright

set mouse=a
set scrolloff=20
set showcmd " show command in status line
set wildmenu

" Search 
set showmatch
set ignorecase
set smartcase
set incsearch

set history=1000

" }}}

" MAPPINGS ----------------------------------------- {{{
" Set the space as the leader key. Must be set before other leader key combos!
" let mapleader = " "

" HOP EASYMOTION
" setup and use colemak keys
lua require'hop'.setup { keys = 'arstdwfpluyhneio', jump_on_sole_occurence = true }
map <Space>f :HopChar1<CR>
map <Space>s :HopChar2<CR>
map <Space>w :HopWord<CR>
map <Space>l :HopLine<CR>
map <Space>h :HopLineStart<CR>
map <Space>t :HopChar1CurrentLineAC<CR>
map <Space>n :HopChar2CurrentLineAC<CR>
map <Space>e :HopWordCurrentLineAC<CR>

" map <Leader>f :HopChar1<CR>
" map <Leader>s :HopChar2<CR>
" map <Leader>w :HopWord<CR>
" map <Leader>l :HopLine<CR>
" map <Leader>h :HopLineStart<CR>
" map <Leader>t :HopChar1CurrentLineAC<CR>
" map <Leader>n :HopChar2CurrentLineAC<CR>
" map <Leader>e :HopWordCurrentLineAC<CR>

nmap <Down> gj
vmap <Down> gj
nmap <Up> gk
vmap <Up> gk

" copy the contents of the entire buffer to system clipboard
nmap gca ggVG"+y
" copy selection to the system clipboard
vmap gy "+y

" traverse the buffer list (taken from Practical Vim)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Switch buffers with F5
nnoremap <F5> :buffers<CR>:buffer<Space>

" open nerdtree with F1
nnoremap <F1> :NERDTreeToggle<CR>
" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" Open the Tagbar with F8
nmap <F8> :TagbarToggle<CR>

" Toggle Minimap with <Leader>m
nnoremap <Leader>m :MinimapToggle<CR>

vnoremap <C-Ins> "+y
" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$
" Ctrl + Backspace to delete word in insert mode (currently not working)
" noremap! <C-BS> <C-w>
" noremap! <C-H> <C-w>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing ALT+H, ALT+J, ALT+K, or ALT+L.
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-h> <c-w>h
nnoremap <a-l> <c-w>l

" FOR TELESCOPE FINDER
" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader><leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader><leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader><leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader><leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" }}}

" COLORSCHEMES ------------------------------------- {{{
let g:onedark_hide_endofbuffer=1
" let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
let g:lightline = {
            \ 'colorscheme': 'onedark'
            \ }
colorscheme onedark
"
" }}}

" VIMSCRIPT ---------------------------------------- {{{
" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

au Filetype c call rainbow#load()
" let g:rainbow_active = 1 " to enable globally

" Disable AutoPairsMultilineClose
let g:AutoPairsMultilineClose = 0

" This function is from Practical Vim, but taken from https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
" it allows pressing @ to execute a macro over all lines in the visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}

" STATUS LINE -------------------------------------- {{{
" }}}