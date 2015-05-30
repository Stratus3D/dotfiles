set nocompatible
filetype off

" Vundle
" Use vundle for plugin management
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Bundles :
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-ragtag'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jimenezrick/vimerl'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'xolox/vim-easytags'
Plugin 'groenewege/vim-less'
Plugin 'elzr/vim-json'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-markdown'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'burnettk/vim-angular'
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()

" File type settings (file type-specific settings in vim/ftplugin/)
" Enable filetype plugin
filetype plugin indent on
autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile *.app setfiletype erlang
autocmd BufRead,BufNewFile *.app.src setfiletype erlang
autocmd BufRead,BufNewFile sys.config setfiletype erlang
autocmd BufRead,BufNewFile Gemfile setfiletype ruby
autocmd BufRead,BufNewFile Vagrantfile setfiletype ruby
autocmd BufRead,BufNewFile Dockerfile setfiletype bash


" General settings
syntax on
set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set guifont=Monaco:h12
set background=dark
set showmatch
set hlsearch
set colorcolumn=80

" Show pastetoggle status
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Turn on cursor column highlighting
set cursorcolumn

" set the color scheme
colorscheme solarized

" Ignored files
set wildignore+=/tmp/,*.so,*.swp,*.swo,*.zip,*.meta,*.prefab,*.png,*.jpg,*.beam

" Allow hidden buffers
set hidden

set runtimepath^=~/.vim/bundle/ctrlp.vim

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

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>
inoremap <Left> <esc> :echoe "Use h"<cr>
inoremap <Right> <esc> :echoe "Use l"<cr>
inoremap <Up> <esc> :echoe "Use k"<cr>
inoremap <Down> <esc> :echoe "Use j"<cr>

" NERDTree settings
nmap <silent> <F3> :NERDTreeToggle<CR>
set guioptions-=T
let NERDTreeShowHidden=1

" CtrlP directory mode
let g:ctrlp_working_path_mode = 0

"open CtrlP in buffer mode
nnoremap <leader>b :CtrlPBuffer<CR>

" custom CtrlP ignores
let g:ctrlp_custom_ignore = {
  \'dir': 'ebin\|DS_Store\|git$\|bower_components\|node_modules\|build\|logs',
  \'file': '\v\.(beam|pyc|swo)$',
  \}

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Hide everything that occupies space on the left side of the file, so we can
" copy the file contents with ease
:nnoremap <F4> :set number! <bar> :GitGutterToggle<CR>

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Custom status bar
set statusline=\ Filename:%-8t                               " Filename
set statusline+=\ Encoding:\%-8{strlen(&fenc)?&fenc:'none'}   " File encoding
set statusline+=\ Line\ Endings:%-6{&ff}                      " Line Endings
set statusline+=\ File\ Type:%-12y                            " File Type
set statusline+=%=%h%m%r%c,%l/%L\ %P        " Cursor location and file status
set laststatus=2
" Color status bar
highlight statusline ctermfg=cyan ctermbg=black guifg=cyan guibg=black

" allow yanking to OSX clipboard
" http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
if $TMUX == ''
    set clipboard+=unnamed
endif

" Start CtrlP on startup
autocmd VimEnter * CtrlP

" Automatically reload .vimrc
autocmd! BufWritePost .vimrc,*vimrc source %

" Keep vim ctags in the tags file like normal
let easytags_file = '~/tags'

" Write to project specific tag file if it exists
set tags=./tags;
let easytags_dynamic_files = 1
let easytags_async = 1

" Load in custom config if it exists
let custom_vimrc='~/dotfiles/mixins/vimrc.custom'
if filereadable(custom_vimrc)
    source custom_vimrc
end
