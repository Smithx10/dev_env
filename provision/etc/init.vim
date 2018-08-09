
" pathogen config bob rawr
execute pathogen#infect()

" editor config
syntax on
filetype plugin indent on
set number
set foldmethod=syntax
set foldlevelstart=50
let javaScript_fold=50

" Yaml
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab"


" tab stops
set expandtab       "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4   "Indent by 4 spaces when pressing <TAB>
set autoindent      "Keep indentation from previous line
set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable

" disable conceal
set conceallevel=0

" white space, returns
set list
set listchars=space:·,eol:§,tab:¤›,extends:»,precedes:«,nbsp:‡
let g:indentLine_char = '|'
let g:indentLine_setConceal = 0

" theme
set termguicolors
set t_Co=256
colorscheme onedark
let g:one_allow_italics = 1

" snippet config
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'


" airline configuration
let g:airline#extensions#tabline#enabled = 1

" Lang === Go
"gofmt
let g:go_fmt_command = "goimports"
autocmd FileType go noremap <C-X> :GoDef<CR>
autocmd Filetype go noremap <C-E> :GoImports<CR>

" javascript
autocmd Filetype .js noremap <C-X> :TernDef<CR>
autocmd Filetype .js noremap <C-E> :FormatCode<CR>

au BufRead,BufNewFile *.yaml.ctmpl,*yml.ctmpl set filetype=yaml


" Global
noremap <C-M> :bnext!<CR>
noremap <C-N> :bprev!<CR>
noremap <C-L> :update<CR>
noremap <C-Q> :bdelete!<CR>
