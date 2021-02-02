call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'APZelos/blamer.nvim'
Plug 'dylanaraps/wal.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'wikitopian/hardmode'
Plug 'kkvh/vim-docker-tools'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'
"Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale' 
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'majutsushi/tagbar'
Plug 'chrisbra/vim-commentary'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

set encoding=UTF-8


"
"colorscheme wal
colorscheme gruvbox
set bg=dark

let g:gruvbox_transparent_bg = 1 

"Swap line
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"Commentary
map ? :Commentary <CR>

"Exit
map qq :q!<CR> 


" line
set clipboard+=unnamedplus
set guioptions+=a

" go back
map gb :e#<CR> 

"upd to real  time 
set autoread 
au FocusGained,BufEnter * :checktime

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

vnoremap <leader>dd "*dd
vnoremap <leader>D "*D
noremap <leader>dd "*dd
noremap <leader>D "*D

"let g:solarized_termcolors=256
syntax on
filetype plugin indent on

set tabstop=2 shiftwidth=2 noexpandtab smarttab
set scrolloff=8
set tw=0 wm=0

"Airline 
let g:airline#extensions#tabline#enabled = 1
"indentLine
let g:indentLine_color_gui = '#A4E57E'

" enable Normal mode keys in ru layout
 set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"


set incsearch
set number relativenumber


"ALE
let g:ale_linters = { 'go' : [ 'gopls', 'govet', 'golint', 'gofmt', 'gobuild' ] }
let g:ale_fixers = { 'go' : [ 'gofmt', 'goimports' ] }
let g:ale_go_gopls_executable = 'gopls'

"coc
" TextEdit might fail if hidden is not set.
"
"

set hidden
"Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"Give more space for displaying messages.
 set cmdheight=1

" nmap <silent> <Leader>i <Plug>(coc-diagnostic-info)
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

"autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <C-o> :call CocAction('doHover')<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for do codeAction of selected region

"fzf
nnoremap <silent> <C-p> :Files<CR>
noremap <silent> <S-f> :BLines<CR>
noremap <silent><C-f> :Rg<CR>

"MULTIURSOR

 map <silent><A-h> <C-Up>
 map <silent><A-l> <C-Down>
" nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
" nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
" nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)

"NErdTREEE
let g:NERDTreeWinSize=25
map <C-b> :NERDTreeToggle<CR>
"Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"Tab 
map tn :tabnew <CR> 
map tk :tabnext<CR>
map tj :tabprev<CR> 
map th :tabfirst<CR>
map tl :tablast<CR>
" show hidden files and dir 
let NERDTreeShowHidden=1

map <C-c> :sp <CR>
map <C-v> :vsp <CR>
map <A-c> 5<C-w>+ <CR>
map <A-v> :vertical resize +5 <CR>
"auto close nerdtree after close file
"let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

" Disable arrow icons at the left side of folders for NERDTree.
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" Docker
map <C-d> :DockerToolsToggle <CR>

" Syntastic
set statusline+=%f
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_loc_list_height = 2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
"let g:syntastic_error_symbol = "E"
""let g:syntastic_warning_symbol = "W"

" hardmode
let g:HardMode_level = 'wannabe'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>



"golang 

let g:go_def_mapping_enabled = 0
map gD :GoReferrers<CR>
map gi :GoImports<CR> 
map gB :GoDebugBreakpoint<CR>
map gn :GoDebugContinue<CR>
map gs :GoDebugTest<CR>
map gt :GoDebugStop<CR>
"map gr :GoRun<CR>
let g:go_def_mode='gopls'
let g:go_term_enabled = 1
let g:go_auto_sameids = 0
let g:go_decls_mode = 'fzf'


au BufReadPost *.vugu set syntax=html

" Tab-bar 
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" if &diff
" highlight! link DiffText MatchParen
" endif

" highlight GitGutterAdd guifg=#009900 ctermfg=Green
" highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
" highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

map gG :G<CR>
map gT :GCheckout<CR>
map gC :Commits<CR>
map gF :diffget //3<CR>
map gJ :diffget //2<CR>

nmap g[ <Plug>(GitGutterNextHunk)
nmap g] <Plug>(GitGutterPrevHunk)
"nmap gi <Plug>(GitGutterEnable)

"git lens 
map gl :BlamerToggle<CR>
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = ' // '


"Terminal  
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
"tnoremap <Esc> <C-\><C-n>
"tnoremap :q! <C-\><C-n>:q!<CR>
"tnoremap <ESC><ESC> <C-\><C-N>


" Rust
"map <C-r> :RustRun<CR>
" PLS JUST NO
"let g:rust_recommended_style = 0
"let g:rustfmt_autosave = 1



"markdown 


let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_custom_header = [
				\ '   _  __ _            __                     ',
				\ '  | |/ /(_)___ ______/ /_  __  ___________ _ ',
				\ '  |   // / __ `/ ___/ __ \/ / / / ___/ __ `/ ',
				\ ' /   |/ / /_/ (__  ) / / / /_/ / /  / /_/ /  ',
				\ '/_/|_/_/\__,_/____/_/ /_/\__,_/_/   \__,_/   ',
        \]

let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/i3/config' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'r': '~/.config/ranger/rc.conf' },
            \ { 'd': '~/.config/dunst/dunstrc' },
            \ { 'p': '~/.config/polybar/config.ini' },
            \ { 'z': '~/.zshrc' },
            \ '~/Projects/go/src/gitlab.com/skso/mvp-api',
						\ '~/Projects/go/src/gitlab.com/skso/chaincode',
						\ '~/Projects/go/src/gitlab.com/skso/docs',
            \ '~/Projects/go/src/github.com/xiashura/Examples',
            \ ]














