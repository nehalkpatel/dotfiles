# ~/.zprofile — login shell profile
# Runs once per login shell, before zshrc. Keep PATH / env bootstrap here.

# Homebrew environment (macOS only)
if [[ "$(uname)" == "Darwin" ]] && [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
