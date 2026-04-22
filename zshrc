# ~/.zshrc - Zsh interactive shell config

# Shared aliases, env, and PATH (works under bash and zsh)
[[ -f ~/.shell_common ]] && source ~/.shell_common

# Vi keybindings with responsive mode switching
bindkey -v
export KEYTIMEOUT=1

# Vi-mode cursor shape: beam for insert, block for normal
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[2 q'
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[6 q'
	fi
}
zle -N zle-keymap-select

# Start with beam cursor
zle-line-init() { echo -ne '\e[6 q' }
zle -N zle-line-init

# Completion
autoload -U compinit && compinit -i
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Shell options
setopt correct              # Auto correct mistakes
setopt extendedglob         # Extended globbing. Allows regular expressions with *
setopt nocaseglob           # Case-insensitive globbing
setopt rcexpandparam        # Array expansion with parameters
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt no_beep              # Don't beep on error.
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

# Tool integrations
command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion zsh)"
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

if [[ -d "${USR_DIR}/share/zsh-syntax-highlighting" ]]; then
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=${USR_DIR}/share/zsh-syntax-highlighting/highlighters
    source ${USR_DIR}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Machine-specific overrides (not tracked in dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
