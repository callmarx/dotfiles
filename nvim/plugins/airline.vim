Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'vim-airline/vim-airline'
" Plug 'dense-analysis/ale'
"" Settings for vim-devicons, NerdFonts and vim-airline
" set guifont=SourceCodePro\ Nerd\ Font\ Regular
" let g:airline_powerline_fonts = 1
" " Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" " Enable Ale with airline
" let g:airline#extensions#ale#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'morhetz/gruvbox'
"" Gruvbox:
" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark='medium'
" colorscheme gruvbox
" set background=dark
