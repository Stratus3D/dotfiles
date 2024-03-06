# Originally this was the blinks zsh theme. I've made extensive modifications
# to it over the years.
#
# Features
#
# * Fast - This shell prompt provides a lot of info but is designed to be fast.
#   The prompt always renders in less than 10ms on my systems.
# * Compact - I don't always have a lot of screen space so keeping the format
#   compact ensure I'll be able to see everything, even if it is in a small
#   tmux pane.
# * Informative - A lot of shells don't provide any indication of what happens
#   when a command finishes. This prompt displays the exit code and the duration
#   of a command when it renders the next prompt
# * Designed for light mode - dark mode is generally the default, but I use
#   light mode.
#
# Format
#
# * Left prompt only. No right prompt.
# * All values are left aligned.
# * First line:
#   * exit code
#   * duration of last command
#   * Number of background jobs
#   * Git info
#   * current user
#   * current directory
# * Second line: `%` for prompt char
#
# Links:
#
# * https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# * https://stackoverflow.com/questions/10194094/zsh-prompt-checking-if-there-are-any-background-jobs
# * https://sureshjoshi.com/development/zsh-prompts-that-dont-suck

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

prompt_bg=white

#ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${bkg}}%B%F{green}%}]"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%(?.%F{14}⏺.%F{9}⏺)%f %2~ %# '
# Show running background jobs, if any
#
# %{%f%k%b%u%}         - A reset. Stop using background color, foreground color, bold, and underline
# %{%K{${prompt_bg}}%} - Set background color for prompt
# - Display previous exit code. Use bold red if failed, otherwise green
#
PROMPT='%{%f%k%b%u%}\
%{%K{${prompt_bg}}%}\
%{%(?.%F{2}%?.%F{%{7}%?)%3G%}\
%{%B%F{blue}%} %(1j.(%j).) %{%b%F{yellow}%K{${prompt_bg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E %{%K{${prompt_bg}}%}%{$fg_bold[red]%}%(?..%?)%{%f%b%}%{%f%k%b%}
$(_prompt_char)%{%K{${prompt_bg}}%} %#%{%f%k%b%} '

#PROMPT='%{%f%k%b%}
#%{%K{${bkg}}%B%F{green}%}%n%{%B%F{blue}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E %{%K{${bkg}}%}%{$fg_bold[red]%}%(?..%?)%{%f%b%}%{%f%k%b%}
#$(_prompt_char)%{%K{${bkg}}%} %#%{%f%k%b%} '

# I no longer use the right prompt because I often forgot it was there
#RPROMPT='%{%K{${bkg}}%}%{$fg_bold[red]%}%(?..%?)%{%f%b%} !%{%B%F{cyan}%}%!%{%f%k%b%}'
