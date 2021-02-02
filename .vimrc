call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'valloric/youcompleteme'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'wikitopian/hardmode'
Plug 'kkvh/vim-docker-tools'
call plug#end()

set encoding=UTF-8

colorscheme wal
syntax on
filetype plugin indent on

set tabstop=2 shiftwidth=2 noexpandtab smarttab
set scrolloff=8
set tw=0 wm=0

set incsearch
set number relativenumber
"fzf
nnoremap <silent> <C-p> :Files<CR>

"MULTICURSOR
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"NErdTREEE
map <C-b> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

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

let g:ycm_autoclose_preview_window_after_completion=1


" Golang 

map <C-r> :GoRun<CR>
map <C-i> :GoImports<CR>


" Rust
"map <C-r> :RustRun<CR>
" PLS JUST NO
let g:rust_recommended_style = 0
let g:rustfmt_autosave = 1
