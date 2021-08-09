function prompt-length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=$#1 m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ));
    done
    local xy
    while (( y > x + 1 )); do
      m=$(( x + (y - x) / 2 ))
      typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
    done
  fi
  echo $x
}

function fill-line() {
  emulate -L zsh
  local left_len=$(prompt-length $1)
  local right_len=$(prompt-length $2 9999)
  local pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
  if (( pad_len < 1 )); then
    # Not enough space for the right part. Drop it.
    echo -E - ${1}
  else
    local pad=${(pl.$pad_len..═.)}  # pad_len spaces
    echo -E - ${1}${pad}${2}
  fi
}

function set-prompt() {
  emulate -L zsh

  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{red}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}  %f"
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}  %f"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{yellow}⮓⮒ %f "
  ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}⮓ %f"
  ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}⮒ %f"
  ZSH_THEME_GIT_PROMPT_RENAMED=" %F{blue}⟛ %f"

  local top_left="%F{magenta}┏┥%F{green}%4c%f %F{cyan} %f$(git_prompt_info) %F{magenta}╞"
  local top_right="╡%F{green}$(date +%H:%M:%S)%F{magenta}│"
  local bottom_left="%F{magenta}┗╾ $(git_prompt_status) %F{green}►%f "
  local bottom_right=""

  setopt PROMPT_SUBST
  PROMPT="$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
  RPROMPT=$bottom_right
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
setopt noprompt{bang,subst} prompt{cr,percent,sp}