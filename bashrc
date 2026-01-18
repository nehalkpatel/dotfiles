# ~/.bashrc - Bash interactive shell config

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc

# Environment
export EDITOR='nvim'
export VISUAL="$EDITOR"
export LESS='-iMnRF'
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups

# Shell options
set -o vi                    # Vi mode
set -o notify                # Report status of terminated bg jobs immediately
set -o noclobber             # Prevent overwriting files with >
shopt -s cdspell             # Autocorrect typos in cd
shopt -s checkwinsize        # Update LINES and COLUMNS after each command
shopt -s cmdhist             # Save multi-line commands as one
shopt -s histappend          # Append to history, don't overwrite
shopt -s extglob             # Extended globbing
shopt -s globstar 2>/dev/null # ** matches all files and directories

# Platform detection
if [[ $(uname) == "Darwin" ]]; then
    export USR_DIR=/opt/homebrew
else
    export USR_DIR=/usr
fi

# PATH
export PATH="$HOME/bin:$PATH"

# Aliases
alias vi='nvim'
alias vim='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias cls='clear'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate -10'

# Python (uv)
alias python='python3'
alias py='python3'
alias pip='uv pip'
alias venv='uv venv'
alias activate='source .venv/bin/activate'

# uv
if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
fi

# fzf
if command -v fzf &>/dev/null; then
    eval "$(fzf --bash)"
fi

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
