set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Background style
set background=dark

" set the color scheme
colorscheme solarized
" TODO: Pull colors for env variables
"execute "set background=".$BACKGROUND
"execute "colorscheme ".$THEME

" Make background transparent since we are using solarized in the terminal
"let g:solarized_termtrans = 1
set t_Co=256
" if &term =~ '256color'
"     set t_ut=
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting
syntax on

" Limit syntax highlighting to 300 columns
set synmaxcol=300

" Only highlight 256 or fewer lines
syntax sync minlines=256

" Show line numbers
set number

" Turn on auto indenting
set autoindent

" Use previous indent
set copyindent

" Tab is for spaces
set tabstop=4

" Number of spaces to use for audo indenting
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Show matching brackets
set showmatch

" Highlight search results
set hlsearch

" Jump to the next match in the file after the cursor
set incsearch

" Wrap around the file when searching
set wrapscan

" Show 4 lines after cursor, useful when reviewing search results
set scrolloff=4

" Show the 80 column line
set colorcolumn=80

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Show pastetoggle status and allow it to be toggled with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Show the curent mode on the last line (command line)
set showmode

" Turn on autocompletion of commands
set wildmenu
set wildmode=full

" Toggle Tagbar
nmap <F9> :TagbarToggle<CR>

" Turn on cursor column highlighting
set cursorcolumn

" don't beep
set visualbell
set noerrorbells

" Font
set guifont=Monaco:h12

" Custom status bar
set statusline=\ Filename:%-8t                               " Filename
set statusline+=\ Encoding:\%-8{strlen(&fenc)?&fenc:'none'}  " File encoding
set statusline+=\ Line\ Endings:%-6{&ff}                     " Line Endings
set statusline+=\ Type:%-12y                                 " File Type
set statusline+=%=%h%m%r                                     " Flags
set statusline+=\ %l/%L                                      " Cursor line and total lines
set statusline+=\ %c                                         " Cursor column
set statusline+=\ %P                                         " Percentage through file
set laststatus=2

" Color status bar
highlight statusline ctermfg=cyan ctermbg=black guifg=cyan guibg=black

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " allow yanking to OSX clipboard
        " http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
        if $TMUX == ''
            set clipboard+=unnamed
        else
            set clipboard=unnamed
        endif
    else
        " Allow yanking to clipboard on Ubuntu
        set clipboard=unnamedplus
    endif
endif

" Use special chars in place of tab and eol
set listchars=eol:¬,tab:→\ ,extends:>,precedes:<,trail:·,space:·

" Ignored files
set wildignore+=/tmp/,*.so,*.swp,*.swo,*.zip,*.meta,*.prefab,*.png,*.jpg,*.beam

" Allow hidden buffers
set hidden

" Use American English when spell checking is turned on
set spelllang=en_us

" Set the spell file to one stored in my dotfiles repo
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add

if has("gui_running")
  set guioption=-t
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
map ; :
map  <Esc> :w
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <Leader>s <esc>:w<CR>
map <Leader>m :Rmodel
imap <esc>:tabn <F7>

" Not sure what these are for
map gT <F8>
map gt <F7>
map :tabn <F8>
map :tabp <F7>
map <Leader>cr <F5>

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>
inoremap <Left> <esc> :echoe "Use h"<cr>
inoremap <Right> <esc> :echoe "Use l"<cr>
inoremap <Up> <esc> :echoe "Use k"<cr>
inoremap <Down> <esc> :echoe "Use j"<cr>

" Allow replacing of searched text by using `cs` on the first result and `n.`
" on all consecutive results
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
            \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Allow easy searching for visually selected text
vnoremap /// y/<C-R>"<CR>

" Allow sudo after opening file
cmap w!! w !sudo tee >/dev/null %

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Toggle everything that occupies space on the left side of the editor
function! ToggleLeftGuides()
    if (g:left_guides_enabled == 1)
        call HideLeftGuids()
        let g:left_guides_enabled = 0
    else
        call ShowLeftGuids()
        let g:left_guides_enabled = 1
    endif
endfunction

" By default everything on the left side is enabled
let g:left_guides_enabled = 1

" Hide everything that occupies space on the left side of the file, so we can
" copy the file contents with ease
function! HideLeftGuids()
    " Hide line numbers
    set nonumber

    " Hide GitGutter
    GitGutterDisable

    " Reset Syntastic, then set it to passive mode, this effectively hides the
    " hints in the left side columns
    SyntasticToggle
    SyntasticReset
endfunction

" Show everything that occupies space on the left side of the file
function! ShowLeftGuids()
    " Show line numbers
    set number

    " Show GitGutter
    GitGutterEnable

    " Run the Syntastic check
    SyntasticCheck
endfunction

:nnoremap <F4>  :call ToggleLeftGuides()<CR>

" Load in custom config if it exists
let custom_vimrc='~/dotfiles/mixins/vimrc.custom'
if filereadable(custom_vimrc)
    source custom_vimrc
end

" Toggle visibility of whitespace characters
nmap <leader>l :set list!<CR>

" Load trailing whitespace functions
source $HOME/.vim/whitespace.vim

"highlight NonText ctermfg=darkgreen guifg=darkgreen
highlight SpecialKey ctermfg=darkgreen guifg=darkgreen

if &filetype == 'html' || exists("java_javascript")
    " JAVA SCRIPT
    "syn include @htmlJavaScript syntax/javascript.vim
    syn include @htmlJavaScript ftdetect/javascript.vim
endif

" BangOpen is useful for open an executable script on the $PATH without having
" to lookup the name manually. For example:
"
" :BangOpen which to_server
"
function! BangOpen(arg)
    execute 'tabe ' . system(a:arg)
endfunction

command! -nargs=1 BangOpen :call BangOpen(<f-args>)

function! SetSpaces(arg)
    echo "settings spaces to: " . a:arg
    execute 'set tabstop=' . a:arg
    execute 'set shiftwidth=' . a:arg
    execute 'set softtabstop=' . a:arg
endfunction

command! -nargs=1 SetSpaces :call SetSpaces(<f-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins and plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load plugins
source $HOME/.vim/plugins.vim

" Start CtrlP on startup
autocmd VimEnter * CtrlP

" Vim-Erlang Skeleton settings
let g:erl_replace_buffer=0
" TODO: Figure out how to copy default erlang templates into our custom dir
" let g:erl_tpl_dir="~/.erlang_templates"

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" NERDTree settings
nmap <silent> <F3> :NERDTreeToggle<CR>
set guioptions-=T
let NERDTreeShowHidden=1

" CtrlP directory mode
let g:ctrlp_working_path_mode = 0

set runtimepath^=$HOME/.vim/bundle/ctrlp.vim

" Vim pencil settings
" Hard wrapping was causing newlines I added to be removed from code in Markdown
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 80

augroup pencil
    autocmd!
    autocmd FileType mkd.markdown,markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
augroup END

"open CtrlP in buffer mode
nnoremap <leader>b :CtrlPBuffer<CR>

" custom CtrlP ignores toggle
function! ToggleCtrlPIgnores()
    if exists("g:ctrlp_user_command")
        " unset the ignores
        let g:ctrlp_custom_ignore = {}
        unlet g:ctrlp_user_command
    else
        " always ignore these patterns
        let g:ctrlp_custom_ignore = {
                    \'dir': 'ebin\|DS_Store\|git$\|bower_components\|node_modules\|logs',
                    \'file': '\v\.(beam|pyc|swo)$',
                    \}
        " also ignore files listed in the .gitignore
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    end
endfunction

call ToggleCtrlPIgnores()
:nnoremap <F6> call ToggleCtrlPIgnores()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type settings (file type-specific settings in vim/ftplugin/)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile sys.config,*.app.src,*.app,*.erl,*.es,*.hrl,*.yaws,*.xrl*.spec setfiletype erlang
autocmd BufRead,BufNewFile Gemfile setfiletype ruby
autocmd BufRead,BufNewFile Vagrantfile setfiletype ruby
autocmd BufRead,BufNewFile Dockerfile setfiletype bash
autocmd BufRead,BufNewFile *gitconfig setfiletype conf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically reload .vimrc
autocmd! BufWritePost .vimrc,*vimrc source %

" TODO: Turn on showcmd when in visual mode
"autocmd VisualEnter * silent execute "set showcmd!"
"autocmd VisualLeave * silent execute "set showcmd!"
