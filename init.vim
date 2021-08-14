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

"" Replace for https://github.com/terryma/vim-multiple-cursors
"" Source: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
" search for a word you want to replace and change the next found occurrence
" with 'cgn' once and then use vim’s most powerful command the '.' (dot).
" Using . you can apply the change to the next word or skip one word with 'n'
" which will jump to the next word.

" SpellCheck
:set spelllang=pt-BR
autocmd FileType md,markdown,rst,text,yaml, setlocal spell spelllang=pt,en

" Põe uma coluna cinza pra identificar quando a linha chega 100 caracteres
highlight ColorColumn ctermbg=gray
set colorcolumn=100

" Cliboard para fora do vim:
" Instale o xclip: sudo pacman -S xclip
set clipboard+=unnamedplus

" deslocar para direita (Visual + >) ou esquerda (Visual + <) sem sair do modo
" visual
vnoremap > >gv
vnoremap < <gv

"Configurações para vim-devicons, NerdFonts e vim-airline
set encoding=UTF-8
set guifont=SourceCodePro\ Nerd\ Font\ Regular
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Habilitar Ale com airline
let g:airline#extensions#ale#enabled = 1

" " Habilita fixers para Elixir
" let g:ale_fixers = { 'elixir': ['mix_format'] }

" let b:ale_fixers = ['prettier', 'eslint']
" let g:ale_linters = { 'ruby': ['brakeman', 'rails_best_practices', 'reek', 'rubocop'] }

" NERDTree:
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
" --> command: SHIFT+n => shortcut to open NERDTree
map <S-n> :NERDTreeToggle<CR>
" --> command: '\t' => go to NERDTree buffer
nnoremap <leader>t :NERDTreeFocus<cr>

" Buffers And Windows:
" --> comand: '\q' => Close the buffer without closing the window (does not close your :split)
nnoremap <leader>q :bp<cr>:bd #<cr>
" --> command: TAB => Walk over the listed buffers
nnoremap <Tab> :bnext<CR>
" --> command: SHIFT+TAB => Walk backwards over the listed buffers
nnoremap <S-Tab> :bprevious<CR>

" Gruvbox:
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
" let g:gruvbox_contrast='soft'
" let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='hard'

" Vim-instant-markdown:
filetype plugin on
let g:instant_markdown_slow = 1
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 0

" Disable quote concealing in JSON files
let g:vim_json_syntax_conceal = 0
" autocmd Filetype json let g:indentLine_enabled = 0

" Nerdcommenter:
" Alinha os comentários em seleção
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" " Configurações de numeração das linhas
" set number relativenumber
" nnoremap <silent> <F2> :RelativizeToggle<CR>
set relativenumber
set number
set number relativenumber

" Prettier — An Opinionated Javascript Formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

" Fzf:
" --> command: CTRL+p => shortcut for :Files (search for file's name)
nnoremap <c-p> :Files<cr>
" --> command: CTRL+f => shortcut for :Ag (search inside files)
nnoremap <c-f> :Ag<cr>

" " Elixir
" let g:ale_fixers = { 'elixir': ['mix_format'] }

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Por padrão, identa com 2 espaços
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" força sintaxe ruby para arquivos.jb
autocmd BufNewFile,BufRead *.jb set syntax=ruby

" Força identação pra algumas linguagens para 2 espaços
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType coffeescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sql setlocal ts=2 sts=2 sw=2 expandtab
" Make file precisa de TAB, então remove identação dele
autocmd FileType make set noexpandtab
