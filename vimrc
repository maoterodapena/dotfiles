"----------------------------------------------------------
" Configuraciones basicas
" ---------------------------------------------------------
scriptencoding utf-8
set encoding=utf-8              " Establece la codificación a UTF-8.

set tabstop=4               " Tabulacion a 4
set softtabstop=4
set shiftwidth=4

"----------------------------------------------------------
" Configuracion interface 
" ---------------------------------------------------------
"
set nocompatible            

set visualbell                  " Activa la alarma visual.
set fillchars=vert:\           " Mejora aspecto de la división de ventanas.
set ttyfast                     " Mejora el redibujado de la pantalla.
set title                       " Añade el nombre del archivo al terminal.
set showcmd                     " Muestra comandos incompletos.
set hidden                      " Oculta los bufferes cerrados.
set ruler                       " Establece una regla permanente.
set lazyredraw                  " Redibuja solo cuando es necesario.
set autoread                    " Actualiza cambios realizados fuera de vim.
set ttimeoutlen=0               " Conmuta instantaneamente entre modos
set backspace=indent,eol,start  " Definir el comportamiento de tecla Backspace
set term=screen-256color        " Evitar problema del color de fondo en tmux

set noswapfile              " Control con git o lo que sea

set expandtab               " Transforma tabs to espacios
set number                  " Muestar numeros de linea
set nocursorline            " No Resalta la linea actual
set relativenumber          " Para mejorar los saltos con j y k

set wildmenu                " autocompletado visual para comandos
set wildmode=longest:list,full   " feo, pero mas comodo para mi

set showmatch               " muestra parejas de ([{

set ignorecase              " mejor busqueda
set smartcase

" mostrar status line
set laststatus=2

" sin division entre splits

"----------------------------------------------------------------------------
" Configuracion busquedas
"----------------------------------------------------------------------------
set incsearch               " muestra las busquedas segun se teclea
set hlsearch                " resalta resultados de la busqueda
nohlsearch

"----------------------------------------------------------------------------
" Configuracion folding
" -----------------------------------------------------
set foldlevelstart=10       " Inicialmente abre carpetas hasta 10 niveles
set foldmethod=marker       " Setea metodo para las folds 
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zr<cr>

"----------------------------------------------------------------------------
" Configuracion movimiento 
"----------------------------------------------------------------------------
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

NeoBundle 'Shougo/unite.vim'        " La madre de todos los plugins
NeoBundle 'Shougo/vimfiler.vim'     " Un explorador de archivos
NeoBundle 'joedicastro/vim-molokai256'  " Mi esquema de color



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

" -------------------------------------------------------
"  unite
"  ------------------------------------------------------
"  TODO
" menus {{{
let g:unite_source_menu_menus = {}

" tecla prefijo para menus (se usa para todos los menus de Unite) {{{
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
" }}}
" Por defecto, busca fuzzy
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" -------------------------------------------------------
"  vimfiler
"  ------------------------------------------------------
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

let g:vimfiler_enabled_auto_cd = 1
call vimfiler#custom#profile('default','context', { 
            \ 'safe' : 0,
            \'auto_cd': 1})
autocmd FileType vimfiler call s:vimfiler_my_settings()

" Abre shell en la carpeta seleccionada en VimFiller
" TODO
function! s:vimfiler_michi_shell_in_dir() "{{{

    let vimfile=vimfiler#get_file() 
    if vimfile.vimfiler__is_directory == 1
        let newdir=vimfiler#get_filename()
    else
        let newdir=fnamemodify(vimfile.action__path,':h')
    end
    lcd `=newdir`
    exe ':shell'
endfunction

function! s:vimfiler_my_settings() "{{{
    call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
    call vimfiler#set_execute_file('txt', 'vim')

    " Overwrite settings.
    nnoremap <silent><buffer> - /
    " Call sendto.
    " nnoremap <buffer> - <C-u>:Unite sendto<CR>
    " setlocal cursorline

    nmap <buffer> O <Plug>(vimfiler_sync_with_another_vimfiler)
    nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
    nmap <buffer> p <Plug>(vimfiler_quick_look)
    nmap <buffer> <LeftRelease> <Plug>(vimfiler_smart_l)
    "nmap <buffer> H :call <SID>vimfiler_michi_shell_in_dir()<cr>

    " para ir por splits de tmux desde un buffer de vimfiler
    nunmap <buffer> <C-j>
    nunmap <buffer> <c-l>

    " Migemo search.
    if !empty(unite#get_filters('matcher_migemo'))
        nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
                    \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
    endif
endfunction"}}}
    
" TODO
" Change current directory.
nnoremap aaa :<C-u>call <SID>cd_buffer_dir()<CR>
function! s:cd_buffer_dir() "{{{
    let filetype = getbufvar(bufnr('%'), '&filetype')
    if filetype ==# 'vimfiler'
        let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
    elseif filetype ==# 'vimshell'
        let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
    else
        let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
    endif

    cd `=dir`
endfunction"}}}

nnoremap <leader>e :<C-U>VimFilerExplorer -buffer-name=explorer<CR>
autocmd filetype explorer :nnoremap <buffer>- /
"nnoremap - /

" -------------------------------------------------------
" Esquemas de color 
" -------------------------------------------------------
syntax on                      " Habilita el resaltado de sintaxis.
set t_Co=256                   " Habilita 256 colores en modo consola.
set background=dark            " Establece el fondo oscuro.
if has('gui_running')          " Habilita el tema molokai para gvim y vim.
    colorscheme molokai
else
    colorscheme molokai256
endif

" -------------------------------------------------------
" Mis mappings
" -------------------------------------------------------
set pastetoggle=<F3>
