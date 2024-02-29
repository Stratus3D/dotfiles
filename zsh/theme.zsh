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
# * Top line: current directory, exit code, duration of last command, Git info.
# * Bottom line: current user, `%` for prompt char

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

bkg=white

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${bkg}}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{${bkg}}%B%F{green}%}%n%{%B%F{blue}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E %{%K{${bkg}}%}%{$fg_bold[red]%}%(?..%?)%{%f%b%}%{%f%k%b%}
$(_prompt_char)%{%K{${bkg}}%} %#%{%f%k%b%} '

# I no longer use the right prompt because I often forgot it was there
#RPROMPT='%{%K{${bkg}}%}%{$fg_bold[red]%}%(?..%?)%{%f%b%} !%{%B%F{cyan}%}%!%{%f%k%b%}'
