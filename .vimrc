" Make right hand home row navigate, just like in i3.
" n is for normal mode, v is visual and select mode
" o is for operator pending mode, i.e. `d2t`
" See the README for a discussion on why this has
" been configured like it has.
nnoremap s l
vnoremap s l
onoremap s l
nnoremap t j
vnoremap t j
onoremap t j
nnoremap n k
vnoremap n k
onoremap n k
" remap Next occurence to Look
nnoremap l n
nnoremap L N
vnoremap l n
vnoremap L N
" Note that other keys now used for navigation
" have not been remapped currently.
" `T` could be remapped somehow, since it could be quite useful.

" Ctrl+S save shortcut
" In normal mode, this should just write the buffer
nmap <C-s> :w<cr>
" In insert mode, go to normal and write
imap <C-s> <esc>:w<cr>

" Comma as leader key
" The leader key is useful in custom shortcuts in order to make
" good shortcuts that do not conflict with native commands.
let mapleader=','

" `,f` - format typescript with deno
" % is a range and means replace the whole buffer
" ! means run a command
" - after the deno fmt command means read from STDIN
" <buffer> means send the buffer to the command (I think!)
autocmd FileType typescript nnoremap <buffer> <leader>f :%!deno fmt -<CR>

" Search highlighting etc.
" Use `:noh` to remove highlighting
set incsearch ignorecase smartcase hlsearch

" Scroll offset, i.e. always display this many lines when scrolling
set scrolloff=10

" Line numbers hybrid mode, i.e. show current line number and the rest
" as relative to the current line. Makes e.g. navigation (`2t`) and
" deleting (`5dd`) easier.
set number relativenumber

" Tabs should be spaces - two of them; along with other smart things
" Note that autoindent is done with `=` in normal mode.
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

" EMMET config
autocmd FileType html,css :packadd emmet-vim
let g:user_emmet_leader_key=','

" DRACULA theme
packadd! dracula
syntax enable
colorscheme dracula

" CTRL-P fuzzy file searching
" Set runtimepath, needed according to the docs
set runtimepath^=~/.vim/bundle/ctrlp.vim

