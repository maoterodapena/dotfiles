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
" Evita problemas de color en tmux (desactiva BCE: Background Color Erase)
set t_ut= 


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
" nnoremap K 5k
"nmap J 5j
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
    autocmd filetype php :nnoremap <buffer><CR> <c-]>
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
vnoremap ñ :
nnoremap - /

" Grabar mas facil con ,, y salir con ,.
noremap <leader><leader> <Esc>:w<Enter>
noremap <leader>. <Esc>:wall<Enter>:q<Enter>
imap <leader><leader> <Esc>:w<Enter>
imap <leader>. <Esc>:wall<Enter>:q<Enter>

 " Cambio rápido entre ventanas {{{
 inoremap <C-h> <Esc><C-w>h
 inoremap <C-j> <Esc><C-w>j
 inoremap <C-k> <Esc><C-w>k
 inoremap <C-l> <Esc><C-w>l
 vnoremap <C-h> <Esc><C-w>h
 vnoremap <C-j> <Esc><C-w>j
 vnoremap <C-k> <Esc><C-w>k
 vnoremap <C-l> <Esc><C-w>l
 nmap <C-h> <C-w>h
 nmap <C-j> <C-w>j
 nmap <C-k> <C-w>k
 nmap <C-l> <C-w>l
 vmap <C-h> <esc><C-h>
 vmap <C-j> <esc><C-j>
 vmap <C-k> <esc><C-k>
 vmap <C-l> <esc><C-l>
 imap <C-h> <esc><C-h>
 imap <C-j> <esc><C-j>
 imap <C-k> <esc><C-k>
 imap <C-l> <esc><C-l>

 " Control-c para cortar en visual
vmap <c-c> "+y

" Vuelve a leer configuracion cuando cambia vimrc
augroup MisAutocmd
    autocmd!
    autocmd BufWritePost .vimrc source %
    " !autocmd ....
augroup END

" Abrir fichero en la ultima linea editada
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif

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
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }
NeoBundle 'joedicastro/vim-molokai256'  " Mi esquema de color
NeoBundle 'mileszs/ack.vim'         " Ack plugin para busquedas
NeoBundle 'vimwiki/vimwiki'      " Mi wikipedia personal
NeoBundle 'leafgarland/typescript-vim'  " Syntax file for TypeScript
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'mattn/emmet-vim'         " html expander

NeoBundle 'scrooloose/syntastic'     " Checkea sintaxis
NeoBundle 'klen/python-mode'
"NeoBundle 'alfredodeza/khuno.vim'
NeoBundle 'SirVer/ultisnips'
"NeoBundle 'honza/vim-snippets'
"NeoBundle 'ervandew/supertab'
NeoBundle "Valloric/YouCompleteMe"

NeoBundle 'sudar/vim-arduino-syntax'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'shawncplus/phpcomplete.vim'


"NeoBundle 'mkusher/padawan.vim'
"NeoBundle 'm2mdas/phpcomplete-extended'
"NeoBundl'm2mdas/phpcomplete-extended-laravel'
"NeoBundle 'phpvim/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }
" Para que al cerrar un buffer no me joda el layout
NeoBundle 'moll/vim-bbye'

NeoBundle 'majutsushi/tagbar'

NeoBundle 'ap/vim-css-color'

NeoBundle 'vim-scripts/restore_view.vim'

NeoBundle 'szw/vim-maximizer'

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

let g:unite_source_history_yank_enable = 1
let g:unite_source_menu_menus = {}
let g:unite_enable_start_insert = 0
let g:unite_enable_short_source_mes = 0
let g:unite_force_overwrite_statusline = 0
let g:unite_prompt = '>>> '
let g:unite_marked_icon = '✓'
let g:unite_update_time = 200
let g:unite_split_rule = 'botright'
let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-group --no-color'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])


nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
nnoremap <silent>[menu]u :Unite -silent -winheight=12 menu<CR>

" Buffers, tabs and windows operations {{{

    nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>

    let g:unite_source_menu_menus.navigation = {
        \ 'description' : '     navigate by buffers, tabs & windows                   ⌘ [space]b', }

    let g:unite_source_menu_menus.navigation.command_candidates = [
        \['buffers                                                    ⌘ ,b', 'Unite buffer'],
        \['tabs', 'Unite tab'],
        \['windows', 'Unite window'],
        \['location list', 'Unite location_list'],
        \['quickfix', 'Unite quickfix'],
        \['new vertical window', 'vsplit'],
        \['new horizontal window', 'split'],
        \['close current window                                       ⌘ ,cw', 'close'],
        \['toggle quickfix window                                     ⌘ ,ll', 'normal ,ll'],
        \['delete buffer                                              ⌘ ,bd', 'bd'],
    \]

    exe 'nnoremap <silent>[menu]b :Unite -silent -winheight='.(len(g:unite_source_menu_menus.navigation.command_candidates) + 2).' menu:navigation<CR>'

" }}}

" File's operations {{{

    nnoremap <leader>uo :<C-u>Unite -no-split -start-insert file<CR>
    nnoremap <leader>uO :<C-u>Unite -no-split -start-insert file_rec/async:!<CR>
    nnoremap <leader>um :<C-u>Unite -no-split file_mru<CR>

    let g:unite_source_menu_menus.files = {
        \ 'description' : '          files & dirs                                          ⌘ [space]o',}

    let g:unite_source_menu_menus.files.command_candidates = [
        \['open file                                                  ⌘ ,uo', 'normal ,uo'],
        \['open file with recursive search                            ⌘ ,uO', 'normal ,uO'],
        \['open more recently used files                              ⌘ ,um', 'normal ,um'],
        \['edit new file', 'Unite file/new'],
        \['search directory', 'Unite directory'],
        \['search recently used directories', 'Unite directory_mru'],
        \['search directory with recursive search', 'Unite directory_rec/async'],
        \['make new directory', 'Unite directory/new'],
        \['change working directory', 'Unite -default-action=lcd directory'],
        \['know current working directory', 'Unite -winheight=3 output:pwd'],
        \['save as root                                               ⌘ :w!!', 'exe "write !sudo tee % >/dev/null"'],
        \['quick save                                                 ⌘ ,w', 'normal ,w'],
    \]

    exe 'nnoremap <silent>[menu]o :Unite -silent -winheight='.(len(g:unite_source_menu_menus.files.command_candidates) + 2).' menu:files<CR>'

" }}}

" Search files {{{

    nnoremap <silent><Leader>ua :Unite -silent -no-quit grep<CR>

    let g:unite_source_menu_menus.grep = {
        \ 'description' : '           search files                                          ⌘ [space]a',
    \}

    let g:unite_source_menu_menus.grep.command_candidates = [
        \['grep (ag → ack → grep)                                     ⌘ ,ua', 'Unite -no-quit grep'],
        \['find', 'Unite find'],
        \['vimgrep (very slow)', 'Unite vimgrep'],
    \]

    exe 'nnoremap <silent>[menu]a :Unite -silent -winheight='.(len(g:unite_source_menu_menus.grep.command_candidates) + 2).' menu:grep<CR>'

" }}}

" vim-maximizer {{{

    let g:unite_source_menu_menus.maximizer= {
        \ 'description' : '      vim-maximizer functions                                        '}

    let g:unite_source_menu_menus.maximizer.command_candidates = [
        \['MaximizerToggle                                            ⌘ F3', 'MaximizerToggle'],
    \]
 

" }}}

" TagBar {{{

    nnoremap <silent>[menu]rt :TagbarToggle<CR>
    nnoremap <silent>[menu]ro :TagbarOpen<CR
    nnoremap <silent>[menu]rc :TagbarClose<CR

    let g:unite_source_menu_menus.tagbar = {
        \ 'description' : '         tagba(r) functions                                    ⌘ [space]r'}

    let g:unite_source_menu_menus.tagbar.command_candidates = [
        \['TagbarOpen                                                 ⌘ [space]ro', 'TagbarOpen'],
        \['TagbarClose                                                ⌘ [space]rc', 'TagbarClose'],
        \['TagbarToggle                                               ⌘ [space]rt', 'TagbarToggle'],
    \]
 
    exe 'nnoremap <silent>[menu]r :Unite -silent -winheight='.(len(g:unite_source_menu_menus.tagbar.command_candidates) + 2).' menu:tagbar<CR>'

" }}}

" Snippets {{{

    nnoremap <silent>[menu]ts :Unite -start-insert ultisnips<CR>
    nnoremap <silent>[menu]te :UltiSnipsEdit<CR>

    let g:unite_source_menu_menus.snippets = {
        \ 'description' : '       snippets and ultisnips functions                      ⌘ [space]t'}

    let g:unite_source_menu_menus.snippets.command_candidates = [
        \['UltiSnipsEdit                                              ⌘ [space]te', 'UltiSnipsEdit'],
        \['snippets source                                            ⌘ [space]ts', 'Unite -start-insert ultisnips'],
    \]
 
    exe 'nnoremap <silent>[menu]t :Unite -silent -winheight='.(len(g:unite_source_menu_menus.snippets.command_candidates) + 2).' menu:snippets<CR>'

" }}}

" Yanks, registers & history {{{

    nnoremap <silent><Leader>ui :Unite -silent history/yank<CR>
    nnoremap <silent><Leader>ur :Unite -silent register<CR>

    let g:unite_source_menu_menus.registers = {
        \ 'description' : '      yanks, registers & history                            ⌘ [space]i'}

    let g:unite_source_menu_menus.registers.command_candidates = [
        \['yanks                                                      ⌘ ,ui', 'Unite history/yank'],
        \['commands       (history)                                   ⌘ q:', 'Unite history/command'],
        \['searches       (history)                                   ⌘ q/', 'Unite history/search'],
        \['registers                                                  ⌘ ,ur', 'Unite register'],
        \['messages', 'Unite output:messages'],
        \['undo tree      (gundo)                                     ⌘ ,uu', 'GundoToggle'],
    \]

    exe 'nnoremap <silent>[menu]i :Unite -silent -winheight='.(len(g:unite_source_menu_menus.registers.command_candidates) + 2).' menu:registers<CR>'

" }}}

" Sessions {{{

    let g:unite_source_menu_menus.sessions = {
        \ 'description' : '       sessions                                              ⌘ [space]s'}

    let g:unite_source_menu_menus.sessions.command_candidates = [
        \['session list', 'Unite session'],
        \['load last auto-session', 'UniteSessionLoad last.vim'],
        \['save session (default)', 'UniteSessionSave'],
        \['save session (custom)', 'exe "UniteSessionSave " input("name: ")'],
    \]

    exe 'nnoremap <silent>[menu]s :Unite -silent -winheight='.(len(g:unite_source_menu_menus.sessions.command_candidates) + 2).' menu:sessions<CR>'

" }}}

" Vim {{{

    let g:unite_source_menu_menus.vim = {
        \ 'description' : '            vim                                                   ⌘ [space]v'}

    let g:unite_source_menu_menus.vim.command_candidates = [
        \['choose colorscheme', 'Unite colorscheme -auto-preview'],
        \['mappings', 'Unite mapping -start-insert'],
        \['edit configuration file (vimrc)', 'edit $HOME/.vim/rc.vim'],
        \['vim help', 'Unite -start-insert help'],
        \['vim commands', 'Unite -start-insert command'],
        \['vim functions', 'Unite -start-insert function'],
        \['vim runtimepath', 'Unite -start-insert runtimepath'],
        \['vim command output', 'Unite output'],
        \['unite sources', 'Unite source'],
        \['kill process', 'Unite -default-action=sigkill process'],
        \['play radio', 'Unite radio'],
        \['launch executable (dmenu like)', 'Unite -start-insert launcher'],
    \]

    exe 'nnoremap <silent>[menu]v :Unite -silent -winheight='.(len(g:unite_source_menu_menus.vim.command_candidates) + 2).' menu:vim<CR>'

" }}}
"
" Text edition {{{

    let g:unite_source_menu_menus.text = {
        \ 'description' : '           text edition                                          ⌘ [space]e'}

    let g:unite_source_menu_menus.text.command_candidates = [
        \['toggle search results highlight                            ⌘ ,[space]', 'set invhlsearch'],
        \['toggle line numbers                                        ⌘ ,on', 'call ToggleRelativeAbsoluteNumber()'],
        \['toggle wrapping                                            ⌘ ,or', 'normal ,or'],
        \['show hidden chars                                          ⌘ ,ol', 'normal ,ol!'],
        \['toggle fold                                                ⌘ /', 'normal za'],
        \['open all folds                                             ⌘ zR', 'normal zR'],
        \['close all folds                                            ⌘ zM', 'normal zM'],
        \['toggle paste mode                                          ⌘ ,p', 'normal ,p'],
        \['show current char info                                     ⌘ ga', 'normal ga'],
    \]

    exe 'nnoremap <silent>[menu]e :Unite -silent -winheight='.(len(g:unite_source_menu_menus.text.command_candidates) + 2).' menu:text<CR>'

" }}}

" Neobundle {{{
"
    let g:unite_source_menu_menus.neobundle = {
        \ 'description' : '      plugins administration with neobundle                 ⌘ [space]n'}

    let g:unite_source_menu_menus.neobundle.command_candidates = [
        \['neobundle', 'Unite neobundle'],
        \['neobundle log', 'Unite neobundle/log'],
        \['neobundle lazy', 'Unite neobundle/lazy'],
        \['neobundle update', 'Unite neobundle/update'],
        \['neobundle search', 'Unite neobundle/search'],
        \['neobundle install', 'Unite neobundle/install'],
        \['neobundle check', 'Unite -no-empty output:NeoBundleCheck'],
        \['neobundle docs', 'Unite output:NeoBundleDocs'],
        \['neobundle clean', 'NeoBundleClean'],
        \['neobundle list', 'Unite output:NeoBundleList'],
        \['neobundle direct edit', 'NeoBundleDirectEdit'],
    \]

    exe 'nnoremap <silent>[menu]n :Unite -silent -winheight='.(len(g:unite_source_menu_menus.neobundle.command_candidates) + 2).' menu:neobundle<CR>'

" }}}

" CtrlP {{{

    let g:unite_source_menu_menus.ctrlp = {
        \ 'description' : '          CtrlP shortcuts                                       ⌘ [space]p'}

    let g:unite_source_menu_menus.ctrlp.command_candidates = [
        \['CtrlP con lineas                                           ⌘ ,pl', ':CtrlPLine'],
    \]

    exe 'nnoremap <silent>[menu]p :Unite -silent -winheight='.(len(g:unite_source_menu_menus.ctrlp.command_candidates) + 2).' menu:ctrlp<CR>'

" }}}
"nnoremap <space>l :CtrlPLine<CR>
"nnoremap <space>t :CtrlPTag<CR>
"nnoremap <space>m :CtrlPMRU<CR>
"nnoremap <space>b :CtrlPBuffer<CR>
"nnoremap <space>p :CtrlPMixed<CR>
" Git {{{

    let g:unite_source_menu_menus.git = {
        \ 'description' : '            admin git repositories                                ⌘ [space]g'}

    let g:unite_source_menu_menus.git.command_candidates = [
        \['git viewer             (gitv)                              ⌘ ,gL', 'normal ,gL'],
        \['git viewer - buffer    (gitv)                              ⌘ ,gl', 'normal ,gl'],
        \['git status             (fugitive)                          ⌘ ,gs', 'normal ,gs'],
        \['git diff               (fugitive)                          ⌘ ,gd', 'normal ,gd'],
        \['git commit             (fugitive)                          ⌘ ,gc', 'normal ,gc'],
        \['git blame              (fugitive)                          ⌘ ,gb', 'normal ,gb'],
        \['git add/stage          (fugitive)                          ⌘ ,ga', 'normal ,ga'],
        \['git checkout           (fugitive)                          ⌘ ,go', 'normal ,go'],
        \['git rm                 (fugitive)                          ⌘ ,gR', 'normal ,gr'],
        \['git push               (fugitive, buffer output)           ⌘ ,gpp', 'normal ,gpp'],
        \['git pull               (fugitive, buffer output)           ⌘ ,gpl', 'normal ,gpl'],
    \]

    exe 'nnoremap <silent>[menu]g :Unite -silent -winheight='.(len(g:unite_source_menu_menus.git.command_candidates) + 2).' menu:git<CR>'

" }}}

" Tags
nnoremap <silent><Leader>ut :Unite -silent -vertical -winwidth=40
\ -direction=topleft -toggle outline<CR>


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
            \ 'find' : 1,
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
    nmap <buffer> <c-r> <Plug>(vimfiler_redraw_screen)

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

nnoremap <leader>e :<C-U>VimFilerExplorer -buffer-name=explorer -find<CR>
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
" vimwiki
" -------------------------------------------------------
let g:vimwiki_list = [{'path': '~/Dropbox/Aplicaciones/Minutes/',
                     \ 'path_html':'/tmp/wikiprueba/html',
                     \ 'custom_wiki2html':'/home/michi/.vim/bundle/vimwiki/autoload/vimwiki/customwiki2html.sh',
                     \ 'syntax':'markdown','ext':'.txt'
                     \},
                     \{'path': '/tmp/wikiprueba', 
                     \ 'syntax':'markdown','ext':'.txt'
                     \}
                     \]
nmap t <Plug>VimwikiToggleListItem
nmap <leader>w- <Plug>VimwikiRemoveHeaderLevel

" -------------------------------------------------------
" Ack
" -------------------------------------------------------
"  Sobreescribo varios, porque el plugin extiende
let g:ack_mappings = {
      \ "t": "",
      \ "T": "",
      \ "o": "<CR>",
      \ "O": "",
      \ "l": "<CR><C-W>p",
      \ "g": "<CR><C-W>p",
      \ "h": "",
      \ "H": "",
      \ "v": "",
      \ "gv": "" }
" -------------------------------------------------------
" UltiSnips
" -------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Directorio privado de snippets 
" let g:UltiSnipsSnippetsDir="/home/moterod/dotfiles/mis-snippets"
" let g:UltiSnipsEnableSnipMate='1'
"let g:UltiSnipsSnippetDirectories = ['/home/moterod/dotfiles/mis-snippets']
let g:UltiSnipsSnippetDirectories=[expand("~/dotfiles/mis-snippets")]



function! UltiSnipsCallUnite()
    Unite -start-insert -winheight=100 -immediately -no-empty ultisnips
    return ''
endfunction

inoremap <silent> <F12> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
nnoremap <silent> <F12> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
" -------------------------------------------------------
" Emmet
" -------------------------------------------------------
" solo para html y css
let g:user_emmet_install_global = 0
autocmd BufRead,BufNewFile *.blade.php set filetype=html
autocmd BufRead,BufNewFile *.vue set filetype=html
autocmd FileType html,css EmmetInstall
autocmd Filetype html setlocal shiftwidth=2 tabstop=2

" -------------------------------------------------------
" Syntastic
" -------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" -------------------------------------------------------
" Mis mappings
" -------------------------------------------------------
set pastetoggle=<F3>
nmap Q <nop>
nmap quit <Esc>:qall!<CR>

let g:unite_enable_start_insert = 1
"nnoremap <C-p> :Unite file_rec/async -start-insert<cr>
nnoremap <space>/ :Unite grep:. -auto-preview<cr>
" nnoremap <space>s :Unite -quick-match buffer<cr>
nnoremap <space>b :Unite -start-insert buffer<cr>



" Mappings ctrlp
"nnoremap <space>l :CtrlPLine<CR>
"nnoremap <space>t :CtrlPTag<CR>
"nnoremap <space>m :CtrlPMRU<CR>
"nnoremap <space>b :CtrlPBuffer<CR>
"nnoremap <space>p :CtrlPMixed<CR>
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("h")': ['<c-h>'],
\ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
\ }
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<space>


" Portapapeles compartido con X
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
"vnoremap y y:w! /tmp/_vim_clipboard<CR>
"vmap p :r /tmp/_vim_clipboard<CR>

" Python settings
" muy lento: let g:syntastic_quiet_messages = { "level": "warnings" }
"let g:syntastic_python_pylint_quiet_messages = { "level" : [] }
let g:syntaxtic_python_checkers = ['']
let g:syntastic_python_flake8_args = '--ignore=E,W,F403'
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["ruby", "php"],
    \ "passive_filetypes": ["python"] }
let g:pymode_run = 0
nmap (( [[
nmap )) ]]
nmap ) ]
nmap ( [
let g:pymode_breakpoint_bind = '<leader>B'
let g:pymode_lint_on_fly = 1
let g:pymode_lint_error_symbol = '▶ '
let g:pymode_lint_todo_symbol = '» '
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'

let g:pymode_lint_ignore = "E501,E128"

let g:pymode_rope_complete_on_dot=0

" Resalta linea en el buffer activo
"augroup cursorline
"    autocmd!
"    autocmd WinLeave,BufLeave * set nocursorline
"    autocmd WinEnter,BufEnter * set cursorline
"augroup end

"let g:syntastic_quiet_messages = {
"        \ "!level":  "errors",
"        \ "type":    "style",
"        \ "regex":   '\m\[C03\d\d\]',
"        \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }
let g:syntastic_quiet_messages = {
        \ "regex":   'pasdfasdfadsf' }

let g:syntastic_c_remove_include_errors = 1
let g:syntastic_cpp_remove_include_errors = 1

"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


""" Padawan
"let $PATH=$PATH . ':' . expand('~/.config/composer/vendor/bin')
"let g:padawan#composer_command = "composer"

"let g:ycm_semantic_triggers = {}
"let g:ycm_semantic_triggers.php =
"            \ ['->', '::', '(', 'use ', 'namespace ', '\']
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }

" phpcomplete-extended
"autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
"let g:phpcomplete_index_composer_command="composer"

let g:EclimCompletionMethod = 'omnifunc'
" Cierra la ventana (pclose) de preview al seleccionar una opcion del
" autocomplete
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" vim-bbye
nnoremap <Leader>q :Bdelete<CR>

" tagbar
nmap <leader>t :TagbarToggle<cr>

" vim-maximizer

