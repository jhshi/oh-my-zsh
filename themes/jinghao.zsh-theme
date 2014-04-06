################################################################################
# show vim mode in prompt
# http://paulgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
################################################################################

vim_ins_mode="%{$fg_bold[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg_bold[green]%}[NOR]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
      vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode
# indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the
# SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
    vim_mode=$vim_ins_mode
    return $(( 128 + $1 ))
}


################################################################################
# Kill The Lag
# http://dougblack.io/words/zsh-vi-mode.html
################################################################################
export KEYTIMEOUT=1

local ret_status="%(?:%{$fg_bold[green]%}➜${reset_color}:%{$fg_bold[red]%}➜${reset_color})"
PROMPT='%{$fg_bold[green]%}[%n@%m]%{$reset_color%} in %{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%} ${vim_mode} ${ret_status} '


ZSH_THEME_GIT_PROMPT_PREFIX="git-branch:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}[untracked]${reset_color}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}[added]${reset_color}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}[modified]${reset_color}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%}[renamed]${reset_color}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}[deleted]${reset_color}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[yellow]%}[ahead]${reset_color}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[red]%}[behind]${reset_color}"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=ZSH_THEME_GIT_PROMPT_BEHIND
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=ZSH_THEME_GIT_PROMPT_AHEAD
