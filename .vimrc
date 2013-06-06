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


nmap <silent> <F3> :NERDTreeToggle<CR>
map  <Esc> :w

if has("gui_running")
  set guioption=-t
endif

set guioptions-=T
let NERDTreeShowHidden=1
