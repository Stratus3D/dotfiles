set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable modelines for security reasons
" See https://thehackernews.com/2019/06/linux-vim-vulnerability.html
set modelines=0
set nomodeline

" Don't allow autocmds from local rc files we don't own
set secure

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

" By default perform case-insensitive searches. To perform case-sensitive use
" /<term>\C
set ignorecase

" Use case insensitive search unless I use an uppercase letter in the search
set smartcase

" Allow certain movement commands to move into the next/previous line when it
" makes sense
set whichwrap=h,l

" Show 4 lines after cursor, useful when reviewing search results
set scrolloff=4

" Set the title of the terminal window
set title

" Don't move cursor to start of line when switching buffers
set nostartofline

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

" Allow paste option to be toggled with F2
set pastetoggle=<F2>

" Show the curent mode on the last line (command line)
set showmode

" Turn on autocompletion of commands
set wildmenu
set wildmode=full

" Turn on insert mode text as-you-type completion
set autocomplete

" Configure as-you-type completions
" menu - show menu when there are multiple possible completions
" menuone - show menu even when there is only one possible completion
" noselect - do not select any menu item by default
" noinsert - do not insert any text until the user selects it
" preview - show extra info about the currently selected completion
" popup - show extra info about completion suggestions
set completeopt=menu,menuone,noselect,noinsert,popup

" Insert completion options
" https://medium.com/usevim/set-complete-e76b9f196f0f
" For a full list of options run :help 'complete'

" Use words from current file, buffers in any open window, and any open buffer
set complete=.,w,b

" Use omnifunc completion for LSP suggestions
set complete+=o

" Use completefunc completion for UltiSnips snippet name suggestions
set complete+=F

" Use tags for completion as well
set complete+=t

" Use words from dictionary for completion
" https://www.reddit.com/r/vim/comments/39l4jt/comment/cs4y7la/
set complete+=k

" Use completions from spell check
set complete+=kspell


" Turn on cursor column highlighting
set cursorcolumn

" Use a visual bell instead of an audible one
set visualbell
set noerrorbells

" But disable even the visible bell as the terminal flashing on OSX is
" annoying
set t_vb=

" The mouse is evil
set mouse=

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
highlight statusline ctermfg=darkcyan ctermbg=white guifg=cyan guibg=black

if has('macunix')
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

" Use special chars in place of tab and eol
set listchars=eol:¬,tab:→\ ,extends:>,precedes:<,trail:·,space:·

" Ignored files
set wildignore+=/tmp/,*.so,*.swp,*.swo,*.zip,*.meta,*.prefab,*.png,*.jpg,*.beam

" Allow hidden buffers, useful for when you want to edit a buffer but not save
" it before working on another buffer.
set hidden

" Configure Vim dictionary with OS words list
" On arch linux run 'sudo pacman -S words' to install this file
set dictionary+=/usr/share/dict/words

" Turn on spell checking for all files
set spell

" Use American English when spell checking is turned on
set spelllang=en_us

" Set the spell file to one stored in my dotfiles repo
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add

" Regenerate binary .spl files from .add files
" https://vi.stackexchange.com/questions/5050/how-to-share-vim-spellchecking-additions-between-multiple-machines
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        silent exec 'mkspell! ' . fnameescape(d)
    endif
endfor

" TODO: Figure out what all these settings do and check in the ones that are
" useful
"set spell noci nosi noai nolist noshowmode

" Don't redraw when executing macros
set lazyredraw

" Display the output of an *incomplete* command in the bottom right
set showcmd

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
" https://github.com/joshukraine/dotfiles/blob/79aae9ac707460877d0fb36a3ef6a9b1ea7c44ce/vim-performance.md
set re=1

" Maintain edit history between sessions in file
set undofile

" Directory for edit history
set undodir=~/.vim/undodir

" Use syntax for folding
set foldmethod=syntax

" By default open files completely unfolded
set foldlevel=99

" Use built in file browser (netrw) instead of NERDTree
" (https://shapeshed.com/vim-netrw/)
" Disable banner
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
" Shortcuts/Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle Tagbar
nmap <F9> :TagbarToggle<CR>

" Make moving between windows easier.
" http://vimcasts.org/episodes/working-with-windows/
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map semicolon to colon for easier invocation of ex commands
map ; :

" Make comma the leader key
let mapleader = ","

" A more convenient buffer write command
map <leader>s <esc>:w<CR>

" Mappings for toggling between line numbers
map <leader>n :set nornu number<CR>
map <leader>r :set rnu number relativenumber<CR>

" Toggle visibility of whitespace characters
nmap <leader>l :set list!<CR>

" JSON formatting with jq
nnoremap <silent> <leader>fj :%!jq '.'<CR>

" Erlang term formatting with erlang_pretty_print
nnoremap <silent> <leader>fe :%!erlang_pretty_print -i<CR>

" Jira ticket command
nnoremap <silent> <leader>to :!open $BASE_TICKET_URL/<c-r>=expand("<cWORD>")<cr>/<CR>

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>
inoremap <Left> <esc> :echoe "Use h"<cr>
inoremap <Right> <esc> :echoe "Use l"<cr>
inoremap <Up> <esc> :echoe "Use k"<cr>
inoremap <Down> <esc> :echoe "Use j"<cr>

" Map tab and shift-tab to insert completion navigation bindings when
" completion menu is visible.
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" Load SortWords function
source $HOME/.vim/sortwords.vim

" Make Q repeat last macro
nnoremap Q @@

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins and plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load plugins
source $HOME/.vim/plugins.vim

" For fzf and vim see
" https://thevaluable.dev/fzf-vim-integration/
" https://github.com/junegunn/fzf.vim
" fzf.vim configuration dictionary
let g:fzf_vim = {}

" disable preview window
let g:fzf_vim.preview_window = []

" Jump to existing window if possible
let g:fzf_vim.buffers_jump = 1


let g:fzf_vim.buffers_options = '--border-label " Open Buffers "'

" display fzf window at bottom like Ctrl-P
let g:fzf_layout = {'window': { 'width': 1, 'height': 20, 'yoffset': 1}}

" key mappings for opening fzf

" leader-b for buffers
nnoremap <leader>b :Buffers<CR>

" ctrl-p for all files (if in Git repo FZF_DEFAULT_COMMAND excludes ignored
" files)
" https://github.com/junegunn/fzf.vim/issues/121#issuecomment-466056060
nnoremap <C-p> :Files<CR>

" ctrl-i for all lines in current file
nnoremap <C-i> :Lines<CR>

" Vim-Erlang Skeleton settings
let g:erl_replace_buffer = 0

" Custom simplified Erlang templates (without all the verbose comment blocks)
let g:erl_tpl_dir = $HOME."/dotfiles/templates/erlang"

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Vim pencil settings
" Hard wrapping was causing newlines I added to be removed from code in Markdown
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 80

" Goyo writing mode callback functions
" I have to toggle vim-pencil in these callbacks because of
" https://github.com/reedes/vim-pencil/issues/75
function! s:goyo_enter()
  autocmd FileType text,mkd.markdown,markdown,mkd call pencil#init()
  :PencilSoft
endfunction

function! s:goyo_leave()
  :PencilOff
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vim-indent-guides settings
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 0
"let g:indent_guides_guide_size = 1

" ALE settings
let g:ale_lint_delay = 400

" Use ale suggestions for omni complete
set omnifunc=ale#completion#OmniFunc

" Custom completion function for available UltiSnips snippets
function! UltiSnipsSnippetName(findstart, base) abort
  if a:findstart
    " Locate the start of the word to be completed, and return the index of it
    let line = getline('.')
    let col = col('.') - 1
    while col > 0 && line[col - 1] =~ '\a'
      let col -= 1
    endwhile

    return col
  else
    " Find any snippets with matching name and return them as suggestions
    let suggestions = []

    " Find any snippets with matching name
    let snippets = UltiSnips#SnippetsInCurrentScope(1)
    echom 'l:snippets %#+v\n' . string(l:snippets)

    for snippet_name in keys(snippets)
      let description = get(snippets, snippet_name)
      let suggestion = {'word': snippet_name, 'menu': description, 'kind': 'S'}

      if snippet_name =~ '^' . a:base
        call add(suggestions, suggestion)
      endif
    endfor

    return suggestions
  endif
endfunction

" Use custom UltiSnips completion function as completefunc
set completefunc=UltiSnipsSnippetName

" Configure ALE fixers
" On all files, removing trailing lines and whitespace
" On Elixir files, run mix format
"
" See
" https://petermalmgren.com/rc-batch-day-9/
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'elixir': ['mix_format']
\}

" Enable specific linters for certain file types
let g:ale_linters = {
\  'erlang': ['dialyzer', 'erlc', 'erlfmt', 'elvis'],
\  'go': ['go build', 'staticcheck']
\}

" Automatically run fixer macros on buffer save, and linters when leaving
" insert mode
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1

" UltiSnips settings
let g:UltiSnipsExpandTrigger=",<tab>"

" Load snippets from dotfiles and from my notes directory
" https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt#L550
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/notes/snippets/"]

" My custom mapping
function! RunTestFileOrLast()
  if (test#test_file(expand('%s')) == 1)
    echo "In a test file"
    :TestFile
  else
    echo "Not in a test file, running last"
    :TestLast
  endif
endfunction

" Run my custom RunTestFileOrLast function when I hit enter
nnoremap <CR> :call RunTestFileOrLast()<CR>

" Run all the tests in the project when I hit shift enter
nnoremap <S-CR> :TestSuite<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type settings (file type-specific settings in vim/ftplugin/)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile sys.config,*.app.src,*.app,*.erl,*.es,*.hrl,*.yaws,*.xrl,*.spec,elvis.config,rebar.lock,*.yrl setfiletype erlang
autocmd BufRead,BufNewFile Gemfile,Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile *.bats set filetype=sh
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
autocmd BufRead,BufNewFile *gitconfig set filetype=conf
" I don't think *.avdl files are valid scala but this is close enough
autocmd BufRead,BufNewFile *.avdl set filetype=scala

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrc
  autocmd!
  " Include ! and ? as word characters, so dw will delete all of e.g. gsub!,
  " and not leave the "!"
  autocmd FileType ruby,eruby,yaml set iskeyword+=!,?

  " Re-source vimrc whenever it changes
  autocmd BufWritePost .vimrc,*vimrc source %

  " Turn on spell checking for file types that contain text
  autocmd FileType markdown,asciidoc,text setlocal spell
augroup END

augroup test
  autocmd!

  " Run tests automatically when a file is saved
  autocmd BufWritePost * if test#exists() |
    \   TestFile |
    \ endif
augroup END

" Taken from https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Always highlight mispellings with and underline and bold text
hi SpellBad cterm=underline,bold

" set default theme, I like xcode
if !exists('g:rtf_theme')
  let g:rtf_theme = 'xcode'
end

" Function for RTF syntax highlighting of the current buffer. Useful when I
" need to paste code with syntax highlighting into PowerPoint or another
" application that supports rich text.
function! RTFHighlight(line1,line2)
  if !executable('pygmentize')
    echoerr "Bummer! pygmentize not found."
    return
  endif

  let content = join(getline(a:line1,a:line2),"\n")
  let lexer=&filetype
  " Run the pygmentize command
  let command = "pygmentize -f rtf -O style=" . g:rtf_theme . " -l " . l:lexer
  let output = system(command, content)
  " Pipe the RTF text to pbcopy
  let retval = system("pbcopy", output)
endfunction

" Invoking RTFHighlight on the current buffer will copy the highlighted code
" to clipboard
command! -range=% RTFHighlight :call RTFHighlight(<line1>,<line2>)

" Use ripgrep for searching files instead of grep
" https://phelipetls.github.io/posts/extending-vim-with-ripgrep/
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ $*
  set grepformat^=%f:%l:%c:%m
endif
