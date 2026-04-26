# Shared helpers for vscode install scripts.
# Caller must set DOTFILES (the path to the vscode/ dir) before sourcing.

resolve_host() {
    HOST="$(hostname -s)"
    HOST_DIR="$DOTFILES/hosts/$HOST"
    if [ ! -d "$HOST_DIR" ]; then
        echo "error: no host config at $HOST_DIR" >&2
        echo "  create the directory or check 'hostname -s' output" >&2
        exit 1
    fi
}

resolve_target() {
    case "$(uname -s)" in
        Darwin) TARGET="$HOME/Library/Application Support/Code/User" ;;
        Linux)
            if [ -d "$HOME/.config/Code - OSS" ]; then
                TARGET="$HOME/.config/Code - OSS/User"
            else
                TARGET="$HOME/.config/Code/User"
            fi
            ;;
        *)
            echo "error: unsupported platform $(uname -s)" >&2
            exit 1
            ;;
    esac
}
