" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
" Plug 'gasparch/vim-elixir-fold'
" Plug 'Yggdroot/indentLine'

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'gabesoft/vim-ags'
Plug 'gabrielelana/vim-markdown'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
" Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'morhetz/gruvbox'
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ryanoasis/vim-devicons'
Plug 'slashmili/alchemist.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --ts-completer' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"" Find And Replace Multiple:
" search for a word you want to replace (you can press '*' to search forwards word) and change the
" next found occurrence with 'cgn' once and then use vim’s most powerful command the '.' (dot).
" Using . you can apply the change to the next word or skip one word with 'n' which will jump to
" the next word.
"" Replacement for https://github.com/terryma/vim-multiple-cursors
"" Source: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

"" Some Default Config:
set encoding=UTF-8
"" Set a gray column to identify when the line reaches 100 characters
highlight ColorColumn ctermbg=gray
set colorcolumn=100
"" Line numbering relative
set nu relativenumber
" copying and clipboard. It's needs to install xclip: sudo pacman -S xclip
set clipboard=unnamedplus
" allow you to go out of a buffer even if it hasn't saved (requires some extra RAM memory)
set hidden
" disables beep (or screen flash) for error messages
set noerrorbells
" disables visual line wrap (moving the cursor will scroll horizontally)
set nowrap
" disables swap files
set noswapfile
" disables backup
set nobackup
" storing the undo information in a file. So you can exit Vim, reboot your computer and still
" undo changes you made. AWESOME!
set undodir=~/.config/nvim/undodir "directory where the undo-files will be saved
set undofile                       "each file will have its own undo-file
" as you get near to the bottom or top of the file it starts scroll down/up when 8 lines remain
set scrolloff=8
" define <space> as map leader
let mapleader=" "
" --> command: CTRL+l ==> clear highlighted search
nnoremap <C-L> :nohls<CR><C-L>

"" Basic Tips:
" --> command: CTRL+u   => Moves cursor to 20 lines up
" --> command: CTRL+d   => Moves cursor to 20 lines down
" --> command: CTRL+wo  => Closes all buffers except the one you are
" --> command: CTRL+wr  => Rotates your current buffers
" --> command: CTRL+wv  => splits vertical
" --> command: CTRL+ws  => splits horizontal

"" SpellCheck:
:set spelllang=pt-BR
autocmd FileType md,markdown,rst,text,yaml, setlocal spell spelllang=pt,en

"" Indentation:
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

"" Force ruby syntax for .jb files
"" Force Dockerfile syntax for Dockerfile.* files
augroup filetypedetect
  au! BufNewFile,BufRead *.jb setf ruby
  au! BufNewFile,BufRead Dockerfile.* setf dockerfile
augroup END

"" Buffers And Windows:
" --> command: <space>+q' => Close the buffer without closing the window (does not close your :split)
nnoremap <leader>q :bp<CR>:bd #<CR>
" --> command: TAB => Walk over the listed buffers
nnoremap <Tab> :bnext<CR>
" --> command: SHIFT+TAB => Walk backwards over the listed buffers
nnoremap <S-Tab> :bprevious<CR>
" --> command: <space>+TAB => Walk over the tab-pages
nnoremap <leader><tab> :tabNext<CR>
" --> command: <space>+tc => Walk over the tab-pages
nnoremap <leader>tc :tabclose<CR>


"" Shift selection to right (Visual + >) or left (Visual + <) without exiting visual mode
vnoremap > >gv
vnoremap < <gv

"" Settings for vim-devicons, NerdFonts and vim-airline
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
" --> command: <space>+N => open/close NERDTree
nnoremap <leader>N :NERDTreeToggle<CR>
" --> command: <space>+n => go to NERDTree buffer
nnoremap <leader>n :NERDTreeFocus<CR>

"" Gruvbox:
" About italics (https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled):
" Most terminals don't handle italics right so gruvbox disables italics for terminals by default.
" But if you're using urxvt or gnome-terminal you should try setting 'let g:gruvbox_italic=1'
" before 'colorscheme' gruvbox to enforce displaying italics
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox
set background=dark

"" Vim-instant-markdown:
filetype plugin on
let g:instant_markdown_autostart = 0
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 0
" --> command: <space>+mp =>  trigger browser preview
noremap <leader>mp :InstantMarkdownPreview<CR>
" --> command: <space>+mc =>  close browser preview
noremap <leader>mc :InstantMarkdownStop<CR>

"" Disable quote concealing in JSON files
let g:vim_json_syntax_conceal = 0

"" Nerdcommenter:
" Align comments in selection
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

"" Prettier — An Opinionated Javascript Formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

"" Telescope:
" --> command: CTRL+p => shortcut for :Telescope find_files (search for file's name)
nnoremap <c-p> :Telescope find_files<CR>
" --> command: CTRL+f => shortcut for :Telescope live_grep (search inside files)
" It requires ripgrep: sudo pacman -S ripgrep
nnoremap <c-f> :Telescope live_grep<CR>

"" YouCompleteMe:
" it avoids autocomplete-preview splits on a new buffer
set completeopt-=preview
" --> command: <space>+dd =>  go to method/function/class definition (when YCM supports)
nnoremap <leader>dd :YcmCompleter GoTo<CR>

"" Fugitive:
" --> command: <space>+ga =>  Same as 'git add -A'
nnoremap <leader>ga :tab Git add -A<CR>
" --> command: <space>+gc =>  Opens a COMMIT_EDITMSG same as 'git commit --verbose' with core.editor
nnoremap <leader>gc :tab Git commit --verbose<CR>
" --> command: <space>+gsh =>  Same as 'git push'
nnoremap <leader>gsh :tab Git push<CR>
" --> command: <space>+gll =>  Same as 'git pull'
nnoremap <leader>gll :tab Git pull<CR>
" --> command: <space>+gs =>  Same as 'git status'
nnoremap <leader>gg :tab Git<CR>
" --> command: <space>+gL =>  Opens two temporary buffers with detailed commit history
nnoremap <leader>gL :tab Gclog -- %<CR>
" --> command: <space>+gb => Opens a temporary buffer with maps for additional triage. Press enter on a
"  line to view the commit where the line changed, or 'g?' to see other available maps. Omit the
"  filename argument will be blame the currently edited file in a vertical split
nnoremap <leader>gb :tab Git blame<CR>
" --> command: <space>+gd => Opens a staged version of the file side by side with the working tree
"  version. Use Vim's diff handling capabilities to apply changes to the staged version, and write
"  that buffer to stage the changes. You can also give an arbitrary ':Gedit' argument to diff
"  against older versions of the file
nnoremap <leader>gd :Gvdiffsplit<CR>

"" Vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
