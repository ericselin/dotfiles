" make right hand home row navigate
" just like in i3
" n is for normal mode, v is visual and select mode
nnoremap s l
vnoremap s l
nnoremap t j
vnoremap t j
nnoremap n k
vnoremap n k
" remap next occurence to Look
nnoremap l n
nnoremap L N
vnoremap l n
vnoremap L N

" fast scrolling with ctrl
nnoremap <C-t> 10j
nnoremap <C-n> 10k

" ctrl+s save shortcut
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>

" search highlighting etc.
set incsearch ignorecase smartcase hlsearch

" scroll offset
set scrolloff=10

" line numbers hybrid mode
set number relativenumber

" tabs should be spaces - two of them
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab
set autoindent
set smartindent

" some tips from
" https://hackernoon.com/how-to-use-vim-for-frontend-development-2020-edition-dac83yyh

" EMMET config
autocmd FileType html,css :packadd emmet-vim
let g:user_emmet_leader_key=','

" DRACULA theme
packadd! dracula
syntax enable
colorscheme dracula

" set runtimepath for ctrl p
set runtimepath^=~/.vim/bundle/ctrlp.vim

