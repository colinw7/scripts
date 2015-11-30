syntax on

set nocindent

set nobackup
set noignorecase
set ruler
set noshowmatch
set nowrapscan
set t_kb=
set shiftwidth=2
set expandtab
set wildmenu
set nohlsearch

"set title
"set notitle

"set mouse=a

let c_space_errors = 1

map fi <%kJ

map [20~ :set ignorecase
map [21~ :set noignorecase

set title
let &titleold=getcwd()
set titlestring=VIM:\ %F 
