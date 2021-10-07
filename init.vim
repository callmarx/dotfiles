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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
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
" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --ts-completer' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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

"" Some Default Config:
set encoding=UTF-8
"" Set a gray column to identify when the line reaches 100 characters.
highlight ColorColumn ctermbg=gray
set colorcolumn=100
"" Line numbering relative.
set nu relativenumber
" Copying and clipboard. It's needs to install xclip, on Arch Linux: 'sudo pacman -S xclip'.
set clipboard=unnamedplus
" Allow you to go out of a buffer even if it hasn't saved (requires some extra RAM memory).
set hidden
" Disables beep (or screen flash) for error messages.
set noerrorbells
" Disables visual line wrap (moving the cursor will scroll horizontally).
set nowrap
" Disables swap files.
set noswapfile
" Disables backup.
set nobackup
" Storing the undo information in a file. So you can exit Vim, reboot your computer and still
" undo changes you made. AWESOME!
set undodir=~/.config/nvim/undodir "directory where the undo-files will be saved
set undofile                       "each file will have its own undo-file
" As you get near to the bottom or top of the file it starts scroll down/up when 8 lines remain.
set scrolloff=8
" Define <space> as map leader.
let mapleader=" "
" --> command: CTRL+l ==> Clear highlighted search.
nnoremap <C-L> :nohls<CR><C-L>

"" SpellCheck:
autocmd FileType md,markdown,rst,text,yaml, setlocal spell spelllang=pt,en

"" Indentation:
" By default, indent with 2 spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Force ruby syntax for .jb files
" Force Dockerfile syntax for Dockerfile.* files
augroup filetypedetect
  au! BufNewFile,BufRead *.jb setf ruby
  au! BufNewFile,BufRead Dockerfile.* setf dockerfile
augroup END

" Force indentation for some languages to 2 spaces.
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType coffeescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sql setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType dockerfile setlocal ts=2 sts=2 sw=2 expandtab
" Make file needs TAB, so unindent it.
autocmd FileType make set noexpandtab

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


"" Buffers And Windows:
" --> command: <space>+q => Close the buffer without closing the window (doesn't close your :split).
nnoremap <leader>q :bp<CR>:bd #<CR>
" --> command: TAB => Walk over the listed buffers.
nnoremap <Tab> :bnext<CR>
" --> command: SHIFT+TAB => Walks backwards over the listed buffers.
nnoremap <S-Tab> :bprevious<CR>
" --> command: <space>+TAB => Walks over the tab-pages.
nnoremap <leader><tab> :tabNext<CR>
" --> command: <space>+tc => Closes current tab-page (and delete eventual unnamed empty buffers)
" NOTE: I only use tab-pages for fugitive plugin, so this command is more like a 'exit' to the
" fugitive features.
nnoremap <leader>tc :tabclose<CR>:call CleanNoNameEmptyBuffers()<CR>

"" Shift selection to right (Visual + >) or left (Visual + <) without exiting visual mode.
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
" --> command: <space>+N => Open/close NERDTree
nnoremap <leader>N :NERDTreeToggle<CR>
" --> command: <space>+n => Go to NERDTree buffer
nnoremap <leader>n :NERDTreeFocus<CR>

"" Gruvbox:
" About italics:
" Most terminals don't handle italics right so gruvbox disables italics for terminals by default.
" But if you're using urxvt or gnome-terminal you should try setting 'let g:gruvbox_italic=1'
" before 'colorscheme' gruvbox to enforce displaying italics.
" source: https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox
set background=dark

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

"" Nerdcommenter:
" Align comments in selection
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

"" Prettier — An Opinionated Javascript Formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

"" Telescope:
" --> command: CTRL+p => Shortcut for :Telescope find_files (search for file's name)
nnoremap <c-p> :Telescope find_files<CR>
" --> command: CTRL+f => Shortcut for :Telescope live_grep (search inside files)
" It requires ripgrep: sudo pacman -S ripgrep
nnoremap <c-f> :Telescope live_grep<CR>

" I kept this comment because I'm always replacing YouCompleteMe to Coc.vim and vice versa
""" YouCompleteMe:
" " it avoids autocomplete-preview splits on a new buffer
" set completeopt-=preview
" " --> command: <space>+dd => Go to method/function/class definition (when YCM supports)
" nmap <silent> gd :YcmCompleter GoTo<CR>

"" Coc:
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" --> command: gd => Go to method/function/class definition.
nmap <silent> gd <Plug>(coc-definition)
" --> command: gy => Go to method/function/class type definition
"  OBS: Go to the type that defines a symbol. For an instance of a class, this will reveal the
"  class itself instead of where the instance is defined.
"  Source: https://medium.com/@nikolalsvk/i-am-looking-inside-the-coc-nvim-documentation-and-what-i-found-is-the-following-518d551eb770
nmap <silent> gy <Plug>(coc-type-definition)
" --> command: gi => Go to method/function/class implementation.
nmap <silent> gi <Plug>(coc-implementation)
" --> command: gr => Open two buffers to listing files that have one or more references and the
"  preview of these files.
nmap <silent> gr <Plug>(coc-references)
" --> command: <space>+rr => Use coc to rename variable, function, class etc on multiple files.
nmap <leader>rr <Plug>(coc-rename)
" --> command: <space>+ac => Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" --> command: <space>+cf => Apply AutoFix to problem on the current line.
nmap <leader>cf  <Plug>(coc-fix-current)
" --> command: <space>+pf => Format current file with your prettier definition.
nmap <leader>pf   :CocCommand prettier.formatFile<CR>
" --> command: <space>+cr => Restart coc.
nnoremap <leader>cr :CocRestart<CR>
" --> command: <space>+k => Show documentation of method/function/class in a preview window with
"  the following custom function.
nnoremap <leader>k :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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
