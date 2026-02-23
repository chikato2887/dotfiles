"""""""""""""""""""""""""
" Leader
"""""""""""""""""""""""""
let mapleader="\<Space>"

"""""""""""""""""""""""""
" Plugins (vim-plug)
"""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'rebelot/kanagawa.nvim'
Plug '~/.local/share/nvim/dev/anaheim.nvim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

call plug#end()

"""""""""""""""""""""""""
" General
"""""""""""""""""""""""""
set encoding=utf8
set tabstop=2
set shiftwidth=2
set expandtab
set number
set norelativenumber
set smartindent
set backspace=indent,eol,start
set title
set list
set listchars=tab:>>-,trail:-,extends:>,precedes:<,nbsp:%
set nrformats-=octal
set hidden
set virtualedit=block
set whichwrap=b,s,[,],<,>
set hlsearch
set incsearch
set ruler
set wildmenu
set scrolloff=20
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set signcolumn=yes
set colorcolumn=80
set cursorline
set termguicolors
set clipboard=unnamedplus

"""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""
" Bracket / quote auto-close
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap () ()
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap '' ''
inoremap ' ''<ESC>i
inoremap "" ""
inoremap " ""<ESC>i
inoremap < <><ESC>i

" Move by display lines
nnoremap k gk
nnoremap j gj

" Tab / Shift+Tab = 検索マッチの次 / 前
nnoremap <Tab> n
nnoremap <S-Tab> N
nnoremap <Esc> :nohlsearch<CR>

" Shift+hjkl = 行頭 / ファイル末尾 / ファイル先頭 / 行末
nnoremap H ^
nnoremap J G
nnoremap K gg
nnoremap L $
vnoremap H ^
vnoremap J G
vnoremap K gg
vnoremap L $

" s = 確認付き置換 / S = 一括置換 (カーソル下の単語)
nnoremap s :%s/<C-r><C-w>//gc<Left><Left><Left>
nnoremap S :%s/<C-r><C-w>//g<Left><Left>
" ビジュアルモード: 選択テキストで置換
vnoremap s "zy:'<,'>s/<C-r>z//gc<Left><Left><Left>
vnoremap S "zy:%s/<C-r>z//gc<Left><Left><Left>

" Ctrl+hjkl = 単語移動 / スクロール (Ctrl+J/K は Smooth Scroll セクションで定義)
nnoremap <C-h> b
nnoremap <C-l> w
vnoremap <C-h> b
vnoremap <C-l> w

" Tab navigation
nnoremap <C-S-t> :tabprevious<CR>
nnoremap <C-t> :tabnext<CR>

"""""""""""""""""""""""""
" Smooth Scroll
"""""""""""""""""""""""""
let s:stop_time = 10

function! s:down(timer) abort
  execute "normal! 3\<C-e>3j"
endfunction

function! s:up(timer) abort
  execute "normal! 3\<C-y>3k"
endfunction

function! s:smooth_scroll(fn) abort
  let working_timer = get(s:, 'smooth_scroll_timer', 0)
  if !empty(timer_info(working_timer))
    call timer_stop(working_timer)
  endif
  if (a:fn ==# 'down' && line('$') == line('w$')) ||
        \ (a:fn ==# 'up' && line('w0') == 1)
    return
  endif
  let s:smooth_scroll_timer = timer_start(s:stop_time, function('s:' . a:fn), {'repeat' : &scroll/3})
endfunction

nnoremap <silent> <C-k> <cmd>call <SID>smooth_scroll('up')<CR>
nnoremap <silent> <C-j> <cmd>call <SID>smooth_scroll('down')<CR>
vnoremap <silent> <C-k> <cmd>call <SID>smooth_scroll('up')<CR>
vnoremap <silent> <C-j> <cmd>call <SID>smooth_scroll('down')<CR>

"""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""
silent! colorscheme kanagawa-dragon

"""""""""""""""""""""""""
" Lightline
"""""""""""""""""""""""""
let g:lightline = {
     \ 'colorscheme': 'kanagawa',
     \ }

"""""""""""""""""""""""""
" coc.nvim
"""""""""""""""""""""""""
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""
nnoremap <C-o> :GFiles<Enter>
nnoremap <C-s> :Rg<Enter>
nnoremap <C-f> /
nnoremap F :call fzf#vim#buffer_lines('', {'options': '--exact'})<CR>

"""""""""""""""""""""""""
" Markdown Preview (browser-based)
"""""""""""""""""""""""""
let g:mkdp_auto_close = 0
autocmd FileType markdown nnoremap <buffer> <silent> <C-p> :MarkdownPreview<CR>
