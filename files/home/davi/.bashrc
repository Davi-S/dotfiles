# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Defines the prompt that appears in your terminal before typing a command.
# The path is in bold sapphire, written as a 24-bit color because the terminal
# palette has no sapphire slot
prompt_min='[\[\e[1;38;2;116;199;236m\]\w\[\e[22;39m\]]\$ '
PS1=$prompt_min

# After a failed command, print its exit code in red below its output. PS0 is
# expanded just before a command runs and marks that one ran, so pressing Enter
# on an empty line does not repeat the last error
PS0='${prompt_ran:0:$((prompt_ran=1, 0))}'
prompt_exit_status() {
    local status=$?
    if (( prompt_ran && status )); then
        printf '\e[31mexit %d\e[39m\n' "$status"
    fi
    prompt_ran=0
    return "$status"
}
PROMPT_COMMAND=(prompt_exit_status)

# Keep much more of the history (fzf's ctrl+r searches it), append to the file
# instead of overwriting it (several terminals), and skip duplicates and
# commands that start with a space
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Common aliases
alias ls='ls --color=auto'
alias ll='ls -AlhF --group-directories-first --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias lg='lazygit'

# Avoid using rm. Use trash-cli instead.
# use `\rm file-without-hope` to bypass this alias.
alias rm='echo "Use trash-put instead of rm, or use \rm to bypass this warning"; false'
alias trm='trash-put'

# My scripts
export PATH="$HOME/bin:$PATH"

# Created by `pipx` on 2025-10-22 13:52:46
export PATH="$PATH:/home/davi/.local/bin"

# Set nvim as the editor
export EDITOR='nvim'
# Visual is for historical reasons. Good to have.
export VISUAL='nvim'

# File colors for ls and other tools that read LS_COLORS, from the theme
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# fzf keybinds in the shell, with the same options and colors as the fzf menus
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/launcher"
eval "$(fzf --bash)"

# zoxide: jump to directories it has learned. Its docs ask for this line to
# stay at the end of the file
alias cd='z'
eval "$(zoxide init bash)"

