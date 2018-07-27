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
let g:solarized_termtrans = 1
set t_Co=256

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
set tabstop=2

" Number of spaces to use for auto indenting
set shiftwidth=2

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
set colorcolumn=80,120

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Comment formatting options
" Auto wrap text
set formatoptions+=tc
" Automatically insert the comment leader after hitting 'o' or 'O'
set formatoptions+=o
" Automatically insert the comment leader after hitting return in insert mode
set formatoptions+=r
" Allow formatting comments with 'gq'
set formatoptions+=q
" Allow numbered lists in comments
set formatoptions+=n

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

" The mouse is evil
set mouse=

" Font
set guifont=Monaco:h12

" Show the status bar
set laststatus=2

" Custom status bar
set statusline=\ Filename:%-8t                               " Filename
set statusline+=\ Encoding:\%-8{strlen(&fenc)?&fenc:'none'}  " File encoding
set statusline+=\ Line\ Endings:%-6{&ff}                     " Line Endings
set statusline+=\ Type:%-12y                                 " File Type
set statusline+=%=%h%m%r                                     " Flags
set statusline+=\ %l/%L                                      " Cursor line and total lines
set statusline+=\ %c                                         " Cursor column
set statusline+=\ %P                                         " Percentage through file
" No need to show the buffer number
"set statusline+=\ Buf:%n                                     " Buffer number

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

" Autocompletion from spell check
" TODO: Figure out if this is needed or not
set complete+=kspell
set complete+=s

" TODO: Figure out what all these settings do and check in the ones that are
" useful
"set spell noci nosi noai nolist noshowmode noshowcmd

if has("gui_running")
  set guioption=-t
endif

" Don't redraw when executing macros
set lazyredraw

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
" https://github.com/joshukraine/dotfiles/blob/79aae9ac707460877d0fb36a3ef6a9b1ea7c44ce/vim-performance.md
set re=1

" Use built in file browser (netrw) instead of NERDTree
" (https://shapeshed.com/vim-netrw/)
let g:netrw_banner = 0
" Make the browser 25% of the width of the editor
let g:netrw_winsize = 25
" Show directory as an expandable tree
let g:netrw_liststyle = 3
" Disable the banner at the top of the buffer
let g:netrw_banner = 0
" Open files in the previous window (e.g. not the netrw file browser window)
let g:netrw_browse_split = 4
" Open files on the right
let g:netrw_altv = 1

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

" JSON formatting with jq
nnoremap <silent> <leader>fj :%!jq '.'<CR>

" Erlang term formatting with erlang_pretty_print
nnoremap <silent> <leader>fe :%!erlang_pretty_print -i<CR>

" Jira ticket command
nnoremap <silent> <leader>to :!open $BASE_TICKET_URL/<c-r>=expand("<cWORD>")<cr>/<CR>

" Make Q repeat last macro
nnoremap Q @@

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
"
" Test running here is contextual in two different ways:
"
" 1. It will guess at how to run the tests. E.g., if there's a Gemfile
"    present, it will `bundle exec rspec` so the gems are respected.
"
" 2. It remembers which tests have been run. E.g., if I'm editing user_spec.rb
"    and hit enter, it will run rspec on user_spec.rb. If I then navigate to a
"    non-test file, like routes.rb, and hit return again, it will re-run
"    user_spec.rb. It will continue using user_spec.rb as my 'default' test
"    until I hit enter in some other test file, at which point that test file
"    is run immediately and becomes the default. This is complex to describe
"    fully, but simple to use in practice: always hit enter to run tests. It
"    will run either the test file you're in or the last test file you hit
"    enter in.
"
" 3. Sometimes you want to run just one test. For that, there's <leader>T,
"    which passes the current line number to the test runner. RSpec knows what
"    to do with this (it will run the first test it finds at or below the
"    given line number). It probably won't work with other test runners.
"    'Focusing' on a single test in this way will be remembered if you hit
"    enter from non-test files, as described above.
"
" 4. Sometimes you don't want contextual test running. In that case, there's
"    <leader>a, which runs everything.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCR()
  nnoremap <cr> :call RunTestFile()<cr>
endfunction
call MapCR()
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Are we in a test file?
    let in_test_file = match(expand("%"), '\(_spec.rb\|_test.rb\|test_.*\.py\|_test.py\)$') != -1

    " Run the tests for the previously-marked file (or the current file if
    " it's a test).
    if in_test_file
        call SetTestFile(command_suffix)
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile(command_suffix)
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@% . a:command_suffix
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
      :w
    end
    " The file is executable; assume we should run
    if executable(a:filename)
      exec ":!./" . a:filename
    " Project-specific test script
    elseif filereadable("script/test")
        exec ":!script/test " . a:filename
    " Fall back to the .test-commands pipe if available, assuming someone
    " is reading the other side and running the commands
    elseif filewritable(".test-commands")
      let cmd = 'rspec --color --format progress --require "~/lib/vim_rspec_formatter" --format VimFormatter --out tmp/quickfix'
      exec ":!echo " . cmd . " " . a:filename . " > .test-commands"

      " Write an empty string to block until the command completes
      sleep 100m " milliseconds
      :!echo > .test-commands
      redraw!
    " Fall back to a blocking test run with Bundler
    elseif filereadable("bin/rspec")
      exec ":!bin/rspec --color " . a:filename
    elseif filereadable("Gemfile") && strlen(glob("spec/**/*.rb"))
      exec ":!bundle exec rspec --color " . a:filename
    elseif filereadable("Gemfile") && strlen(glob("test/**/*.rb"))
      exec ":!bin/rails test " . a:filename
    " If we see python-looking tests, assume they should be run with Nose
    elseif strlen(glob("test/**/*.py") . glob("tests/**/*.py"))
      exec "!nosetests " . a:filename
    end
endfunction

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

" Erlang plugin settings. TODO: Pull these from the environment
" let g:erl_author=""
" let g:erl_company=""

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

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
                    \'file': '\v\.(beam|pyc|swo|jpg)$',
                    \}
        " also ignore files listed in the .gitignore
        " This command returns all text files under version control
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
        "let g:ctrlp_user_command = '(cd %s; git grep --cached -Il "") || find %s -type f'
    end
endfunction

call ToggleCtrlPIgnores()
"let g:ctrlp_user_command = '(cd %s; git grep --cached -Il "") || find %s -type f'
:nnoremap <F6> call ToggleCtrlPIgnores()<CR>

" vim-indent-guides settings
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 0
"let g:indent_guides_guide_size = 1

let g:ale_lint_delay = 400

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type settings (file type-specific settings in vim/ftplugin/)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile sys.config,*.app.src,*.app,*.erl,*.es,*.hrl,*.yaws,*.xrl,*.spec setfiletype erlang
autocmd BufRead,BufNewFile Gemfile,Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile Dockerfile,*.bats set filetype=sh
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
autocmd BufRead,BufNewFile *gitconfig set filetype=conf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically reload .vimrc
autocmd! BufWritePost .vimrc,*vimrc source %

" TODO: Turn on showcmd when in visual mode
"autocmd VisualEnter * silent execute "set showcmd!"
"autocmd VisualLeave * silent execute "set showcmd!"
