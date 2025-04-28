" Vundle
" Use vundle for plugin management
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins

" For writing
" For writing, a focus mode
Plugin 'junegunn/goyo.vim'

" For writing, soft line wrap and other misc. features
Plugin 'reedes/vim-pencil'

" Provides the gz command for titlecasing selected text
Plugin 'christoomey/vim-titlecase'

" Language
" Erlang
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-tags'
Plugin 'vim-erlang/vim-erlang-skeletons'


" Elixir
Plugin 'elixir-editors/vim-elixir'

" Golang
Plugin 'fatih/vim-go'

" Lua
Plugin 'xolox/vim-misc' " required by vim-lua-ftplugin
Plugin 'xolox/vim-lua-ftplugin'

" SASS/SCSS/Less/CSS
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'

" Mustache
Plugin 'mustache/vim-mustache-handlebars'

" For productivity
Plugin 'tpope/vim-ragtag'

" File fuzzy finder
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" Maybe try https://github.com/tpope/vim-commentary instead?
Plugin 'scrooloose/nerdcommenter'

" ale for syntax checking
Plugin 'w0rp/ale'

" For navigating via ctags with Ctrl-]
Plugin 'ludovicchabant/vim-gutentags'

" For visual table and column alignment with :Tab /<column delimiter>
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plugin 'godlygeek/tabular'

" For tab completion
Plugin 'ervandew/supertab'

" Git plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Interactive Graphviz and dot compiling
" I have considered moving to https://github.com/liuchengxu/graphviz.vim
" but lacks the :GraphvizInteractive command which I like to use
Plugin 'wannesm/wmgraphviz.vim'

" For easy math in Vim
Plugin 'arecarn/vim-selection'
Plugin 'arecarn/vim-crunch'

" Ultisnips for code snippet management
Plugin 'SirVer/ultisnips'

" Easier movements, mapped to <Leader> <Plug>(easymotion-prefix)
" On the fence about whether I should continue using easymotion or switch to
" something simpler like
" https://www.reddit.com/r/vim/comments/1yfzg2/comment/cfkaxw5/
Plugin 'easymotion/vim-easymotion'

" Quickly run tests
Plugin 'vim-test/vim-test'

" To display the number of search matches and the index of current match in
" the search results. The only reason I'm using this over the native feature
" in Vim 8 is because this provides a total count under all scenarios, whereas
" Vim natively shows >99 when number of results is greater than 100. See
" https://vi.stackexchange.com/a/23296
Plugin 'google/vim-searchindex'

" A private plugin I wrote for myself that allows me to quickly jump between
" a file in Vim and file on the Git host website (e.g. GitHub or BitBucket)
Plugin 'git@github.com:Stratus3D/git-hop.vim.git'

call vundle#end()

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins I no longer use
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Not needed anymore
"Plugin 'altercation/vim-colors-solarized'

" I want to use it but it was buggy, need to figure out what is going on.
"Plugin 'nathanaelkane/vim-indent-guides'

" Not using tagbar because I didn't feel like the tag info was helpful.
"Plugin 'majutsushi/tagbar'

" Sublime like minimap
" Decided against this as it doesn't really help me keep track of my location
" in the file
" Plugin 'severin-lemaignan/vim-minimap'

" Tmux
" Disabled this plugin because it broke the C-l mapping to refresh Vim
" Plugin 'christoomey/vim-tmux-navigator'

" I decided against this plugin because 1). it's got a pretty specific use
" case, and I don't do much with colors in CSS and 2). it's not really enough
" color for me to get an accurate idea of what the color is when I'm in the
" terminal.
" Plugin 'ap/vim-css-color'

" I no longer use haml
" Plugin 'tpope/vim-haml'

" CoffeeScript
"Plugin 'kchmck/vim-coffee-script'

" Go
"Plugin 'fatih/vim-go'

" For frameworks
"Plugin 'tpope/vim-rails'

" In-editor file browser. Disabled because of poor performance
"Plugin 'scrooloose/nerdtree'
