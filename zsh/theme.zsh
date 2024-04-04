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
# * https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
# * https://stackoverflow.com/questions/10194094/zsh-prompt-checking-if-there-are-any-background-jobs
# * https://sureshjoshi.com/development/zsh-prompts-that-dont-suck
# * https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/timer/timer.plugin.zsh

prompt_bg=white

# These are used by the `git_prompt_info` info function invoked in the prompt
ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${prompt_bg}}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# The code below was taken from the ohmyzsh timer plugin
zmodload zsh/datetime

__prompttimer_current_time() {
  zmodload zsh/datetime
  echo $EPOCHREALTIME
}

__prompttimer_format_duration() {
  local mins=$(printf '%.0f' $(($1 / 60)))
  local secs=$(printf "%.${TIMER_PRECISION:-1}f" $(($1 - 60 * mins)))
  local duration_str=$(echo "${mins}m${secs}s")
  local format="${TIMER_FORMAT:-%d}"
  echo "${format//\%d/${duration_str#0m}}"
}

__prompttimer_save_time_preexec() {
  __prompttimer_cmd_start_time=$(__prompttimer_current_time)
}

__prompttimer_save_timer_display_precmd() {
  # set to default of empty string
  __prompttimer_prev_cmd_duration=""
  if [ -n "${__prompttimer_cmd_start_time}" ]; then
    local cmd_end_time=$(__prompttimer_current_time)
    local tdiff=$((cmd_end_time - __prompttimer_cmd_start_time))
    unset __prompttimer_cmd_start_time
    if [[ -z "${TIMER_THRESHOLD}" || ${tdiff} -ge "${TIMER_THRESHOLD}" ]]; then
        local tdiffstr=$(__prompttimer_format_duration ${tdiff})
        local cols=$((COLUMNS - ${#tdiffstr} - 1))
        __prompttimer_prev_cmd_duration=" ${tdiffstr}"
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook preexec __prompttimer_save_time_preexec
add-zsh-hook precmd __prompttimer_save_timer_display_precmd

# Show running background jobs, if any
#
# %{%f%k%b%u%}         - A reset. Stop using background color, foreground color, bold, and underline
# %{%K{${prompt_bg}}%} - Set background color for prompt
# %(?.%F{green}%?.%B%F{%{red}%}%?) - Display previous exit code. Use bold red if failed, otherwise green
# %{%F{yellow}%}$__timer_prev_cmd_duration - Display the duration of the previous command in yellow
# %{%B%F{blue}%}%(1j. (%j).) - Display the number jobs if one or more
# %{%B%F{green}%}$(git_prompt_info) - Show Git info if inside a Git repository
# %{%b%F{magenta}%}%~   - Display the current directory in magenta bold font
# %E %{%f%b%u%}        - Clear to end of line, reset everything except background color
# %#                   - Display # prompt if root, and % if not
# %{%f%k%b%u%}         - The reset again.

PROMPT='%{%f%k%b%u%}\
%{%K{${prompt_bg}}%}\
%(?.%F{green}%?.%B%F{%{red}%}%?)\
%{%b%F{yellow}%}$__prompttimer_prev_cmd_duration\
%{%B%F{blue}%}%(1j. (%j).)\
%{%B%F{green}%}$(git_prompt_info)\
 %{%b%F{cyan}%}%n\
 %{%b%F{magenta}%}%~\
%E %{%f%b%u%}
%#\
%{%f%k%b%u%} '
