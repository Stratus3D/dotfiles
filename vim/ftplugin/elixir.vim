" Hack to get ExDocs available in Vim
" https://til.codeinthehole.com/posts/about-how-to-use-keywordprg-effectively/

" Define command for loading keyword help in split and set it as keywordprg
" for Elixir files
funct ElixirKeywordHelp()
  " Hack so that we use full module.function name as keyword
  set iskeyword+=46
  " Grab the whole module.func string as a WORD
  let l:module_fun = expand('<cword>')
  set iskeyword-=46
  silent exe ':hor term bash -c "elixir-help ' . shellescape(l:module_fun) . '" 2>/dev/null'
endfunction

command! -buffer -nargs=1 ElixirKeywordPrg call ElixirKeywordHelp()

setlocal keywordprg=:ElixirKeywordPrg
