"" Some Default Config:
set encoding=UTF-8
highlight ColorColumn ctermbg=gray
set colorcolumn=100
set nu relativenumber
set clipboard=unnamedplus
set title
set hidden
set noerrorbells
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set mouse=a
set scrolloff=8
set sidescrolloff=8
set splitright
set wildmenu
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set backup
set backupdir=~/.local/share/nvim/backupdir
set undodir=~/.config/nvim/undodir
set undofile
let mapleader=" "

"" Nvim Config Shortcut:
nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

"" Shift selection to right (Visual + >) or left (Visual + <) without exiting visual mode.
vnoremap < <gv
vnoremap > >gv

" Clear highlighted search.
nnoremap <C-L> :nohls<CR><C-L>

" Spell Check for specific files
autocmd FileType md,markdown,rst,text,yaml, setlocal spell spelllang=pt,en

"" Custom Functions:
" Looks for empty for empty and unnamed buffers then close its if find some.
function! CleanNoNameEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
  if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
  else
    echo 'No buffer deleted'
  endif
endfunction

" Classic function to clean unnecessary white spaces.
function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" call this function when you save a file.
autocmd BufWritePre * :call TrimWhitespace()
call plug#begin('~/.vim/plugged')

" Plug 'elixir-editors/vim-elixir'
Plug 'gabrielelana/vim-markdown'
Plug 'leafgarland/typescript-vim'

" Plug 'airblade/vim-gitgutter'
" Plug 'junegunn/fzf.vim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'pangloss/vim-javascript'
" Plug 'elzr/vim-json'
" Plug 'gabesoft/vim-ags'
" Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

" Plug 'alvan/vim-closetag'
"" Closetag:
" let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/nerdtree.vim

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'slashmili/alchemist.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

call plug#end()


"" Buffers And Windows:
" Close the buffer without closing the window (doesn't close your :split).
nnoremap <leader>q :bp<CR>:bd #<CR>
" Walk over the listed buffers.
nnoremap <Tab> :bnext<CR>
" Walks backwards over the listed buffers.
nnoremap <S-Tab> :bprevious<CR>
" Walks over the tab-pages.
nnoremap <leader><tab> :tabNext<CR>
" Closes current tab-page (and delete eventual unnamed empty buffers)
nnoremap <leader>tc :tabclose<CR>:call CleanNoNameEmptyBuffers()<CR>
" NOTE: I only use tab-pages for fugitive plugin, so this command is more like a 'exit' to the
" fugitive features.

"" Vim-instant-markdown:
filetype plugin on
let g:instant_markdown_autostart = 0
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 0
" --> command: <space>+mp => Trigger browser preview
noremap <leader>mp :InstantMarkdownPreview<CR>
" --> command: <space>+mc => Close browser preview
noremap <leader>mc :InstantMarkdownStop<CR>

"" Disable quote concealing in JSON files
let g:vim_json_syntax_conceal = 0

"" Prettier — An Opinionated Javascript Formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

"" Telescope:
" --> command: CTRL+p => Shortcut for :Telescope find_files (search for file's name)
nnoremap <c-p> :Telescope find_files<CR>
" --> command: CTRL+f => Shortcut for :Telescope live_grep (search inside files)
" It requires ripgrep: sudo pacman -S ripgrep
nnoremap <c-f> :Telescope live_grep<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Fugitive:
" --> command: <space>+ga => Same as 'git add -A'.
nnoremap <leader>ga :tab Git add -A<CR>
" --> command: <space>+gc => Open a COMMIT_EDITMSG same as 'git commit --verbose' with editor
nnoremap <leader>gc :tab Git commit --verbose<CR>
" --> command: <space>+gsh => Same as 'git push'.
nnoremap <leader>gsh :tab Git push<CR>
" --> command: <space>+gll => Same as 'git pull'.
nnoremap <leader>gll :tab Git pull<CR>
" --> command: <space>+gg => Open a temporary buffer with uncommitted files that each can be expand
"  with '=' to show details (toggling).
nnoremap <leader>gg :tab Git<CR>
" --> command: <space>+gL => Open two temporary buffers with detailed commit history.
nnoremap <leader>gL :tabnew<CR>:Gclog<CR>
" --> command: <space>+gb => Open a temporary buffer with maps for additional triage. Press enter
"  on a line to view the commit where the line changed, or 'g?' to see other available maps. Omit
"  the filename argument will be blame the currently edited file in a vertical split.
nnoremap <leader>gb :tab Git blame<CR>
" --> command: <space>+gD => Open a staged version of the file side by side with the working tree
"  version. Use Vim's diff handling capabilities to apply changes to the staged version, and write
"  that buffer to stage the changes. You can also give an arbitrary ':Gedit' argument to diff
"  against older versions of the file.
nnoremap <leader>gD :tab Gvdiffsplit<CR>

"" Vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"""""""""
" " Force ruby syntax for .jb files
" " Force Dockerfile syntax for Dockerfile.* files
" augroup filetypedetect
"   au! BufNewFile,BufRead *.jb setf ruby
"   au! BufNewFile,BufRead Dockerfile.* setf dockerfile
" augroup END

" " Force indentation for some languages to 2 spaces.
" autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType coffeescript setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType sql setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType dockerfile setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
" " Make file needs TAB, so unindent it.
" autocmd FileType make set noexpandtab

"" Basic Tips:
" --> command: CTRL+u   => Moves cursor to 20 lines up.
" --> command: CTRL+d   => Moves cursor to 20 lines down.
" --> command: CTRL+wo  => Closes all buffers except the one you are.
" --> command: CTRL+wr  => Rotates your current buffers.
" --> command: CTRL+wv  => Splits vertical.
" --> command: CTRL+ws  => Splits horizontal.
" --> command: CTRL+o   => Go back in the 'jump list'. You can see yours with :jumps.
" --> command: CTRL+i   => Go forward in the 'jump list'.

"" Find And Replace Multiple:
" search for a word you want to replace (you can press '*' to search forwards word) and change the
" next found occurrence with 'cgn' once and then use vim’s most powerful command the '.' (dot).
" Using . you can apply the change to the next word or skip one word with 'n' which will jump to
" the next word.
"" Replacement for https://github.com/terryma/vim-multiple-cursors
"" Source: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
" Note: You can use coc-rename instead
