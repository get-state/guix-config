"__/\\\________/\\\___/\\\\\\\\\\\___/\\\\____________/\\\\_
"_\/\\\_______\/\\\__\/////\\\///___\/\\\\\\________/\\\\\\_
" _\//\\\______/\\\_______\/\\\______\/\\\//\\\____/\\\//\\\_
"  __\//\\\____/\\\________\/\\\______\/\\\\///\\\/\\\/_\/\\\_
"   ___\//\\\__/\\\_________\/\\\______\/\\\__\///\\\/___\/\\\_
"    ____\//\\\/\\\__________\/\\\______\/\\\____\///_____\/\\\_
"     _____\//\\\\\___________\/\\\______\/\\\_____________\/\\\_
"      ______\//\\\_________/\\\\\\\\\\\__\/\\\_____________\/\\\_
"       _______\///_________\///////////___\///______________\///__
"  vim.rc file
"
" ========================================================================
set encoding=utf-8
set relativenumber number
set colorcolumn=81
set noshowmode
set laststatus=2
set encoding=utf-8
set fileencoding=utf-8
set completeopt=menu,menuone,noselect
set shortmess+=I
set cursorline
set cursorlineopt=number
set listchars+=space:.,eol:↴
syntax off
let g:tex_flavor = 'latex'
let g:livepreview_previewer = 'zathura'
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" lua stuff
lua require('config')
