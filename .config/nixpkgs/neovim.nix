{
	config = ''

set encoding=UTF-8


syntax on
set tabstop=2 shiftwidth=2 noexpandtab smarttab
set scrolloff=8
set tw=0 wm=0

"Swap line
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


"Commentary
map ? :Commentary <CR>

map qq :q!<CR>

map f :call CocAction('format')<CR>

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


" enable Normal mode keys in ru layout
 set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"

set incsearch
set number relativenumber

map gG :G<CR>
map gT :GCheckout<CR>
map gC :Commits<CR>
map gF :diffget //3<CR>
map gJ :diffget //2<CR>

nmap g[ <Plug>(GitGutterNextHunk)
nmap g] <Plug>(GitGutterPrevHunk)
"nmap gi <Plug>(GitGutterEnable)

"git lens 
"map gl :BlamerToggle<CR>
"let g:blamer_enabled = 1
"let g:blamer_delay = 500
"let g:blamer_show_in_visual_modes = 1
"let g:blamer_show_in_insert_modes = 0
"let g:blamer_prefix = ' // '


"fzf
nnoremap <silent> <C-p> :Files<CR>
noremap <silent> <S-f> :BLines<CR>
noremap <silent><C-f> :Rg<CR>



"NErdTREEE
let g:NERDTreeWinSize=25
map <C-b> :NERDTreeToggle<CR>
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
let g:NERDTreeGitStatusConcealBrackets = 1
" Disable arrow icons at the left side of folders for NERDTree.
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"





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
" go to back
map gb :e#<CR> 

" Use K to show documentation in preview window.
nnoremap <C-o> :call CocAction('doHover')<CR>


"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for do codeAction of selected region



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


"Multi_cursor_use_default_mapping
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-m>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'



	'';
}
