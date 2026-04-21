# Shared shell config sourced by ~/.zshrc and ~/.bashrc.
# Works under both zsh and bash; avoid shell-specific syntax here.

# --- Environment ---
export EDITOR='nvim'
export VISUAL="$EDITOR"
export LESS='-iXFR'

# Platform detection
case "$(uname)" in
    Darwin) export USR_DIR=/opt/homebrew ;;
    *)      export USR_DIR=/usr ;;
esac

# --- PATH ---
export PATH="$HOME/bin:$PATH"

# --- Aliases ---
# Editor
alias vi='nvim'
alias vim='nvim'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Listing — BSD ls on macOS uses -G; GNU ls uses --color=auto
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Search / disk
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias cls='clear'

# free only exists on Linux
if command -v free >/dev/null 2>&1; then
    alias free='free -h'
fi

# Git shortcuts
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
