vim.cmd [[
try
  colorscheme gruvbox
  set background=dark
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#ale#enabled = 1
  let g:gruvbox_italic=1
  let g:gruvbox_contrast_dark='medium'
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
