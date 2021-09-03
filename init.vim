" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
" Plug 'gasparch/vim-elixir-fold'
" Plug 'suan/vim-instant-markdown'
" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py' }
" Plug 'Yggdroot/indentLine'

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'gabesoft/vim-ags'
Plug 'gabrielelana/vim-markdown'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ryanoasis/vim-devicons'
Plug 'slashmili/alchemist.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Xuyuanp/nerdtree-git-plugin'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"" Replacement for https://github.com/terryma/vim-multiple-cursors
" search for a word you want to replace and change the next found occurrence
" with 'cgn' once and then use vim’s most powerful command the '.' (dot).
" Using . you can apply the change to the next word or skip one word with 'n'
" which will jump to the next word.
"" Source: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

"" SpellCheck
:set spelllang=pt-BR
autocmd FileType md,markdown,rst,text,yaml, setlocal spell spelllang=pt,en

"" Set a gray column to identify when the line reaches 100 characters
highlight ColorColumn ctermbg=gray
set colorcolumn=100

""Copying to Clipboard:
" Install xclip: sudo pacman -S xclip
set clipboard=unnamedplus

"" Shift selection to right (Visual + >) or left (Visual + <) without exiting visual mode
vnoremap > >gv
vnoremap < <gv

"" Settings for vim-devicons, NerdFonts and vim-airline
set encoding=UTF-8
set guifont=SourceCodePro\ Nerd\ Font\ Regular
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Enable Ale with airline
let g:airline#extensions#ale#enabled = 1

"" NERDTree:
autocmd StdinReadPre * let s:std_in=1
" --> Start NERDTree when Vim is started without file arguments
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" --> Start NERDTree when Vim starts with a directory argument
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" --> Displays hidden files ('.env', '.git/', '.gitignore' etc)
let NERDTreeShowHidden=1
" --> disable NERDTree help text
let NERDTreeMinimalUI=1
" --> command: '\'+'n' => shortcut to open/close NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" --> command: '\'+'t' => go to NERDTree buffer
nnoremap <leader>t :NERDTreeFocus<cr>

"" Buffers And Windows:
" --> comand: '\q' => Close the buffer without closing the window (does not close your :split)
nnoremap <leader>q :bp<cr>:bd #<cr>
" --> command: TAB => Walk over the listed buffers
nnoremap <Tab> :bnext<CR>
" --> command: SHIFT+TAB => Walk backwards over the listed buffers
nnoremap <S-Tab> :bprevious<CR>

"" Gruvbox:
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'

" Vim-instant-markdown:
filetype plugin on
let g:instant_markdown_slow = 1
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 0

"" Disable quote concealing in JSON files
let g:vim_json_syntax_conceal = 0

"" Nerdcommenter:
" Align comments in selection
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

"" Line numbering settings:
set number relativenumber

"" Prettier — An Opinionated Javascript Formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

"" Fzf:
" --> command: CTRL+p => shortcut for :Files (search for file's name)
nnoremap <c-p> :Files<cr>
" --> command: CTRL+f => shortcut for :Ag (search inside files)
nnoremap <c-f> :Ag<cr>

"" Vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1


"" Force ruby syntax for .jb files
autocmd BufNewFile,BufRead *.jb set syntax=ruby

"" Indentation settings:
" By default, indent with 2 spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
" Force indentation for some languages to 2 spaces
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType coffeescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sql setlocal ts=2 sts=2 sw=2 expandtab
" Make file needs TAB, so unindent it
autocmd FileType make set noexpandtab
