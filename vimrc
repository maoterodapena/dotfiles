"----------------------------------------------------------
" Configuracion interface 
" ---------------------------------------------------------
"
set nocompatible            " TODO

set tabstop=4               " Tabulacion a 4
set softtabstop=4
set softtabstop=4
set shiftwidth=4

set noswapfile              " Control con git o lo que sea

set expandtab               " Transforma tabs to espacios
set number                  " Muestar numeros de linea
set showcmd                 " Muestra el ultimo comando abajo a la derecha
set nocursorline              " Resalta la linea actual
set hidden                  " Puedo cambiar de buffer sin grabar
set relativenumber          " Para mejorar los saltos con j y k

set wildmenu                " autocompletado visual para comandos
set wildmode=longest:list,full   " feo, pero mas comodo para mi


set lazyredraw              " solo redibuja cuando hace falta

set showmatch               " muestra parejas de ([{

set ignorecase              " mejor busqueda
set smartcase

" mostrar status line
set laststatus=2

"--------------------------------------------------------------------------------
" Configuracion busquedas
"--------------------------------------------------------------------------------
set incsearch               " muestra las busquedas segun se teclea
set hlsearch                " resalta resultados de la busqueda
nohlsearch
" Pulsar dos veces escape borra el resaltado de los resultados de busqueda
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

"--------------------------------------------------------------------------------
" Configuracion folding
" ---------------------------------------------------------
set foldlevelstart=10       " Inicialmente abre carpetas hasta 10 niveles
set foldmethod=marker       " Setea metodo para las folds 
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zr<cr>

"--------------------------------------------------------------------------------
" Configuracion movimiento 
"--------------------------------------------------------------------------------
" El raton algunas veces esta bien
set mouse=a
nmap <RightMouse> :set paste<cr>"+gP:set nopaste<cr>

" Scroll mas rapido
nnoremap K 5k
nnoremap J 5j
nmap <Leader>J :join<CR>

" Cambio de buffers
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>

" Mapeo lider y su timeout para anular
let mapleader=','
let maplocalleader= ' '
set timeoutlen=400

augroup AusNavegacion
    autocmd!
    " Navegacion en help con <enter> (C-] no es comodo con teclado espanol
    autocmd filetype help :nnoremap <buffer><CR> <c-]>
augroup END

" Mueve al principio linea
function! MichiGoFirstColum()
    let pos = getpos(".")
    :normal ^
    if pos[2] == getpos(".")[2]
        let pos[2]=0
        call setpos(".",pos)
    endif
endfunction
nnoremap <silent> 0 :call MichiGoFirstColum()<CR>

" Mejorar algunas teclas dificiles de pulsar en espanol
nnoremap ñ :
nnoremap - /

" Grabar mas facil con ,, y salir con ,.
noremap <leader><leader> <Esc>:w<Enter>
noremap <leader>. <Esc>:wall<Enter>:q<Enter>
imap <leader><leader> <Esc>:w<Enter>
imap <leader>. <Esc>:wall<Enter>:q<Enter>

 " Cambio rápido entre ventanas {{{
 nnoremap <C-h> <C-w>h
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l

 " Control-c para cortar en visual
vmap <c-c> "+y

" Vuelve a leer configuracion cuando cambia vimrc
augroup MisAutocmd
    autocmd!
    autocmd BufWritePost .vimrc source %
    " !autocmd ....
augroup END

"*****************************************************************************
"" NeoBundle core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

let g:vim_bootstrap_langs = "python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"

  " Run shell script if exist on custom select language
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'



"*****************************************************************************
"" NeoBundle install packages
"*****************************************************************************
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'



call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"*****************************************************************************
"" Configuracion de paquetes
"*****************************************************************************
" vim-airline
let g:airline_theme = 'raven'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '|' " ▶
  let g:airline_left_alt_sep      = '|' " »
  let g:airline_right_sep         = '|' " ◀
  let g:airline_right_alt_sep     = '|' " «
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_min_count = 2
" 
" let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#excludes = []
" "configure whether buffer numbers should be shown. >
let g:airline#extensions#tabline#buffer_nr_show = 1
" "configure how buffer numbers should be formatted with |printf|. >
let g:airline#extensions#tabline#buffer_nr_format = '%s.'
"configure the formatting of filenames (see |filename-modifiers|). >
"let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamemod = ':t:r'
"configure collapsing parent directories in buffer name. >
let g:airline#extensions#tabline#fnamecollapse = 1
"configure truncating non-active buffer names to specified length. >
let g:airline#extensions#tabline#fnametruncate = 0
" enable virtualenv
let g:airline#extensions#virtualenv#enabled = 1


