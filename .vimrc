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
" remap Until to untiL
onoremap l t
onoremap L T
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
autocmd FileType typescriptreact nnoremap <buffer> <leader>f :%!deno fmt -<CR>

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

" theme
packadd! nord-vim
syntax enable
colorscheme nord

" CTRL-P fuzzy file searching
" Set runtimepath, needed according to the docs
set runtimepath^=~/.vim/bundle/ctrlp.vim

" go vim for html files
autocmd BufRead,BufNewFile */layouts/*/*.html set ft=gohtmltmpl

" CoC config
" mostly from https://github.com/neoclide/coc.nvim
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" ultisnip key commands
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-t>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="tabdo"

" use <c-space> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

