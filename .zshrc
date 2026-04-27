# Created by newuser for 5.9
eval "$(starship init zsh)"
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export EDITOR='nvim'
export VISUAL='nvim'
# Only run fastfetch if this is an interactive session
if [[ -o interactive ]]; then
    fastfetch
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/phuc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/phuc/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/phuc/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/phuc/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
