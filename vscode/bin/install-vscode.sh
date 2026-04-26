#!/usr/bin/env bash
# Set up VSCode for this host: render User settings, then install any
# missing extensions from hosts/$(hostname -s)/extensions.txt.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HOST="$(hostname -s)"
HOST_DIR="$DOTFILES/hosts/$HOST"
if [ ! -d "$HOST_DIR" ]; then
    echo "error: no host config at $HOST_DIR" >&2
    echo "  create the directory or check 'hostname -s' output" >&2
    exit 1
fi

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

CLI=""
for c in code code-insiders codium code-oss; do
    if command -v "$c" >/dev/null 2>&1; then CLI="$c"; break; fi
done
if [ -z "$CLI" ] && [ "$(uname -s)" = "Darwin" ]; then
    for app in \
        "/Applications/Visual Studio Code.app" \
        "/Applications/Visual Studio Code - Insiders.app"; do
        path="$app/Contents/Resources/app/bin/code"
        if [ -x "$path" ]; then CLI="$path"; break; fi
    done
fi
[ -z "$CLI" ] && { echo "error: no VSCode CLI found on PATH or in /Applications" >&2; exit 1; }

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

mkdir -p "$TARGET"

# --- phase 1: settings + symlinks ---
inputs=("$DOTFILES/common/settings.json")
if [ -s "$HOST_DIR/manifest.txt" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%%#*}"
        line="$(echo "$line" | xargs || true)"
        [ -z "$line" ] && continue
        frag="$DOTFILES/fragments/$line.json"
        [ -f "$frag" ] || { echo "error: fragment $frag not found" >&2; exit 1; }
        inputs+=("$frag")
    done < "$HOST_DIR/manifest.txt"
fi
[ -f "$HOST_DIR/overlay.json" ] && inputs+=("$HOST_DIR/overlay.json")

for f in "${inputs[@]}"; do
    jq -e . "$f" >/dev/null || { echo "error: invalid JSON in $f" >&2; exit 1; }
done

tmp="$(mktemp "$TARGET/.settings.json.XXXXXX")"
jq -s 'reduce .[] as $x ({}; . * $x)' "${inputs[@]}" > "$tmp"
mv "$tmp" "$TARGET/settings.json"

echo "host: $HOST"
echo "wrote $TARGET/settings.json"
echo "  merged:"
for f in "${inputs[@]}"; do echo "    ${f#$DOTFILES/}"; done

if [ -f "$DOTFILES/common/keybindings.json" ]; then
    ln -snf "$DOTFILES/common/keybindings.json" "$TARGET/keybindings.json"
    echo "linked $TARGET/keybindings.json"
fi

if [ -d "$DOTFILES/common/snippets" ]; then
    mkdir -p "$TARGET/snippets"
    for f in "$DOTFILES/common/snippets/"*; do
        [ -e "$f" ] || continue
        ln -snf "$f" "$TARGET/snippets/$(basename "$f")"
    done
fi

if [ -f "$HOST_DIR/mcp.json" ]; then
    ln -snf "$HOST_DIR/mcp.json" "$TARGET/mcp.json"
    echo "linked $TARGET/mcp.json"
fi

# --- phase 2: extensions ---
LIST="$HOST_DIR/extensions.txt"
if [ ! -f "$LIST" ]; then
    echo "no extensions.txt; skipping extension install"
    exit 0
fi

echo "checking extensions (using $CLI)..."
installed="$("$CLI" --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]' | sort -u)"
wanted="$(awk 'NF && !/^[[:space:]]*#/' "$LIST" | tr '[:upper:]' '[:lower:]' | sort -u)"
missing="$(comm -23 <(printf '%s\n' "$wanted") <(printf '%s\n' "$installed") | grep -v '^$' || true)"

if [ -z "$missing" ]; then
    echo "all extensions already installed"
else
    echo "installing missing:"
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        "$CLI" --install-extension "$ext" --force
    done <<< "$missing"
fi
