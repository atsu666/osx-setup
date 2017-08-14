if has("gui_running")
  source ~/.vimrc
endif

noremap <c-j> <esc>
noremap! <c-j> <esc>
set noswapfile " swpを無効化
set nobackup "バックアップファイルを作らない
set list " スペースの可視化
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:% " スペースの可視化
set number "行番号を表示
set incsearch "インクリメンタルサーチ
set ignorecase "検索時に大文字小文字を無視
set tabstop=4 " タブを表示するときの幅
set softtabstop=4
set shiftwidth=4 " タブを挿入するときの幅
set expandtab
set clipboard=unnamed,autoselect    " クリップボードと連携
set showmatch       " 対応する括弧を表示
set autoindent      " 新しい行のインデントを現在行と同じにする
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
let &t_SI.="\e[6 q"
let &t_EI.="\e[1 q"

" #############
" # NeoBundle
" #############
function! s:WithoutBundles()
  " インストールされていない
endfunction

function! s:LoadBundles()
  " plugins
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'altercation/vim-colors-solarized'
endfunction

" NeoBundle がインストールされているなら LoadBundles() を呼び出す
" そうでないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#begin(expand('~/.vim/bundle/'))
      NeoBundleFetch 'Shougo/neobundle.vim'
      call s:LoadBundles()
    catch
      call s:WithoutBundles()
    endtry 
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()

" Use vsplit mode
if has("vim_starting") && !has('gui_running') && has('vertsplit')
    function! EnableVsplitMode()
        " enable origin mode and left/right margins
        let &t_CS = "y"
        let &t_ti = &t_ti . "\e[?6;69h"
        let &t_te = "\e[?6;69l\e[999H" . &t_te
        let &t_CV = "\e[%i%p1%d;%p2%ds"
        call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
    endfunction

    " old vim does not ignore CPR
    map <special> <Esc>[3;9R <Nop>

    " new vim can't handle CPR with direct
    " map <expr> ^[[3;3R EnableVsplitMode()
    set t_F9=<C-V><ESC>
    map <expr> <t_F9> EnableVsplitMode()
    let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif

call neobundle#end()

" ##############
" # status line
" ##############
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
:set laststatus=2

" ##########
" # ctrlp
" ##########
set runtimepath^=~/.vim/bundle/ctrlp.vim
set tags=tags,./tags,**1/tags,tags;/Projects
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" ###########
" # NERDTree
" ###########
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" ###############
" # color scheme
" ###############
syntax enable
set background=dark
colorscheme solarized

