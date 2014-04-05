function prompt_char {
    if [ $UID -eq 0 ]; then 
        echo "#"
    else 
        echo $
    fi
}

PROMPT='%{$fg_bold[green]%}[%n@%m] %{$fg[cyan]%}${PWD/#$HOME/~}%{$reset_color%} $(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
