"""""""""""""""""""""""""
" leaderの変更
"""""""""""""""""""""""""
let mapleader="\<Space>"

"""""""""""""""""""""""""
"括弧、クオーテーションの閉じ補完

inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap () ()
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>

"補完: ' " 
inoremap '' ''
inoremap ' ''<ESC>i
inoremap "" ""
inoremap " ""<ESC>i
inoremap < <><ESC>i

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" 論理行ではなく, 表示行で移動を行うマッピング
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" tabの移動
nmap <Tab> :tabnext<Return>
nmap <S-Tab> :tabprev<Return>

""""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'Shougo/unite.vim'

" 最近使ったファイルを表示する
Plug 'Shougo/neomru.vim'

"ファイルをツリー表示
Plug 'scrooloose/nerdtree'

" gitをvimから使う
Plug 'tpope/vim-fugitive'

" 各言語の補完を行う
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" コメントの一括挿入を行う
Plug 'tpope/vim-commentary' 

" クオーテーションや、括弧の囲みを便利にする
Plug 'tpope/vim-surround'

" dev-icons
Plug 'ryanoasis/vim-devicons'

" 目に優しいカラースキーム
Plug 'ulwlu/elly.vim'

" 良い感じのstatuslineにする
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"""""""""""""""
" smooth scroll ref: https://zenn.dev/matsui54/articles/2021-03-17-smooth-scroll
"""""""""""""""
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

nnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
nnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>
vnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
vnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>

"""""""""""""""""""""""""""
" 一般設定
""""""""""""""""""""""""""""""'
set encoding=utf8
set tabstop=2
set shiftwidth=2
set number

"文字コード
""set fenc=utf-8

" バックスペースを空白, 行末, 行頭でも使えるようにする
set backspace=indent,eol,start

" ターミナルのタイトルをセットする
set title

"改行時に自動でインデントしてくれる
set smartindent

" 空白文字の可視化
set list

" 可視化する文字のデザイン
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 0で始まる数値を8進数として扱わない
set nrformats-=octal

" ファイルの保存をしていなくても別のファイルを開けるようにする
set hidden

" 文字の無いところにカーソル移動できるようにする
set virtualedit=block

"カーソルの回り込みができるようにする
set whichwrap=b,s,[,],<,>

"検索結果のハイライト
set hlsearch

" 入力中の文字列で即座に検索を行う
set incsearch

" 画面右にrulerの表示
set ruler

" 補完候補をステータス行に表示
set wildmenu

" 直前の行によって、インデントの数を増減する
set smartindent

" スクロール時のカーソルが画面の一番下にこないように設定	
set scrolloff=20

" 行の相対数を表示
set relativenumber

" 行の絶対数を表示
set nu

" エラー時のビープ音の削除
set noerrorbells

" tab文字をスペースに
set expandtab

" 一行が長い時に折り返さない"
set nowrap

" swpファイル出力無効
set noswapfile

" バックアップファイル出力無効
set nobackup

" undo履歴を保存しておく. vimを閉じてもundoできるようになる"
set undodir=~/.vim/undodir
set undofile

" 行数の左にエクストラなカラムを表示する. ここにエラーなどが出る"
set signcolumn=yes

" 80行目に縦線を追加. 1行が長いことの目安"
set colorcolumn=80

" カレント行をハイライト"
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
 "" https://stackoverflow.com/questions/8640276/how-do-i-change-my-vim-highlight-line-to-not-be-an-underline

" 目に優しいカラースキームの有効化
colorscheme elly
set termguicolors
let g:airline_theme='elly'


" ステータスラインの表示を行う
let g:lightline = {
     \ 'colorscheme': 'elly',
     \ }
 
""""""""""
" NERDTreeのショートカット
""""""""""
" nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-e> :NERDTreeFind<CR>

" exploreが最後のペインだったら、vimを終了する"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

""""""""""""""
" coc-nvim 
""""""""""""""
"error/warning highlight"
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 補完のカーソル移動時にタブで移動可能にする
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"""""""""""""""""""""""""""
" enable dev-icons"
"""""""""""""""""""""""""""
set guifont=<FONT_NAME>:h<FONT_SIZE>
set guifont=DroidSansMono\ Nerd\ Font:h11
" or:
set guifont=DroidSansMono_Nerd_Font:h11

nnoremap <C-o> :GFiles<Enter>
nnoremap <C-s> :Rg<Enter>
