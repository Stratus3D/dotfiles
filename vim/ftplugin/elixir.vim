" Hack to get ExDocs available in Vim
"
" Define command for loading keyword help in split and set it as keywordprg
" for Elixir files
funct ElixirKeywordHelp()
  " Hack so that we use full module.function name as keyword
  let l:old_iskeyword = &iskeyword
  set iskeyword+=46

  silent exe ':hor term bash -c "elixir-help ' . shellescape(expand('<cword>')) . '" 2>/dev/null'
  let &iskeyword = l:old_iskeyword
endfunction

command! -buffer -nargs=1 ElixirKeywordPrg call ElixirKeywordHelp()

setlocal keywordprg=:ElixirKeywordPrg
