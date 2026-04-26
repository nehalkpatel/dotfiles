#!/usr/bin/env bash
# Render the host's VSCode user settings into the live Code User dir.
# Merges common/settings.json + listed fragments + host overlay.json,
# then symlinks keybindings, snippets, and any host-specific mcp.json.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "$DOTFILES/bin/_lib.sh"

resolve_host
resolve_target

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

mkdir -p "$TARGET"

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
