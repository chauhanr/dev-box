set textwidth=100 

set relativenumber 
set encoding=UTF-8
set number 
set ttyfast 
set showcmd 

set noswapfile 

set runtimepath^=~/.vim/bundle/ctrlp.vim

abbr _sh #!/bin/bash

call pathogen#infect()
syntax on 
filetype plugin indent on 
set termguicolors
colorscheme monokai


let g:go_fmt_command = "goimports"
map <C-n> :NERDTreeToggle<CR>
map <C-g> :GoDefStack<CR> 
map <C-d> :GoDecls<CR>
map <C-u> :GoTest<CR> 
map <C-b> :GoBuild<CR>
map <C-r> :GoRun<CR> 
map <C-f> :GoTestFunc<CR> 
map <C-a> :GoAlternate<CR> 
map <C-u> :Ack

nnoremap <leader>a :cclose<CR>
nnoremap <leader>p :pc<CR> 
nnoremap <leader>m :cprevious<CR>
nnoremap <leader>n :cnext<CR> 


" Remap jk to escape 
inoremap jk <Esc>  
