# ~/.bashrc - Bash interactive shell config

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc

# Shared aliases, env, and PATH (works under bash and zsh)
[[ -f ~/.shell_common ]] && source ~/.shell_common

# History
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

# Tool integrations
command -v uv       >/dev/null 2>&1 && eval "$(uv generate-shell-completion bash)"
command -v fzf      >/dev/null 2>&1 && eval "$(fzf --bash)"
command -v direnv   >/dev/null 2>&1 && eval "$(direnv hook bash)"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"

# Machine-specific overrides (not tracked in dotfiles)
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
