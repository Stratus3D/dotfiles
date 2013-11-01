set nocompatible
filetype off

" Vundle
" Use vundle for plugin management
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundles :
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'airblade/vim-gitgutter'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'elixir-lang/vim-elixir'
Bundle 'jimenezrick/vimerl'

" General settings
syntax on
set number
set autoindent
set tabstop=4
set shiftwidth=2
set expandtab
set guifont=Monaco:h12
colorscheme solarized
set background=dark
set pastetoggle=<F2>
set showmatch
set hlsearch

" Allow hidden buffers
set hidden

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Enable filetype plugin
filetype plugin indent on

" Shortcuts ============================
let mapleader = ","
map ; :
map  <Esc> :w
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <Leader>s <esc>:w<CR>
map <Leader>m :Rmodel
imap <esc>:tabn <F7>
map gT <F8>
map gt <F7>
map :tabn <F8>
map :tabp <F7>
map <Leader>cr <F5>

if has("gui_running")
  set guioption=-t
endif

" NERDTree settings
nmap <silent> <F3> :NERDTreeToggle<CR>
set guioptions-=T
let NERDTreeShowHidden=1

"open CtrlP in buffer mode
nnoremap <leader>b :CtrlPBuffer<CR>

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" allow yanking to OSX clipboard
" set clipboard+=unnamed

" Not sure if I am going to ever use this stuff
"You can use <c-j> to goto the next <++> - it is pretty smart.

" Start CtrlP on startup
autocmd VimEnter * CtrlP

"JavaScript
autocmd BufRead,BufNewFile *.tmpl,*.htm,*.js inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("function <++>(<++>) {\n<++>;\nreturn <++>;\n}")<CR>
autocmd BufRead,BufNewFile *.tmpl,*.htm,*.js inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<CR>
autocmd BufRead,BufNewFile *.tmpl,*.htm,*.js inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<CR>
autocmd BufRead,BufNewFile *.tmpl,*.htm,*.js inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<CR>

"HTML
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> cahref <c-r>=IMAP_PutTextWithMovement('<a href="<++>"><++></a>')<CR>
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> cbold <c-r>=IMAP_PutTextWithMovement('<b><++></b>')<CR>
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> cimg <c-r>=IMAP_PutTextWithMovement('<¿mg src="<++>" alt="<++>" />')<CR>
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> cpara <c-r>=IMAP_PutTextWithMovement('<p><++></p>')<CR>
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> ctag <c-r>=IMAP_PutTextWithMovement('<<++>><++></<++>>')<CR>
autocmd BufRead,BufNewFile *.tmpl,*.js,*.htm inorea <buffer> ctag1 <c-r>=IMAP_PutTextWithMovement("<<++>><CR><++><CR></<++>>")<CR>

"Python
autocmd BufNewFile,BufRead *.py inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<CR>
autocmd BufRead,BufNewFile *.py inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<CR>
autocmd BufRead,BufNewFile *.py inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<CR>
autocmd BufRead,BufNewFile *.py inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<CR>
autocmd BufRead,BufNewFile *.py inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<CR>

"Press c-q insted of space (or other key) to complete the snippet
imap <C-q> <C-]>
