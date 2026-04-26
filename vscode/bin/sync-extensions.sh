#!/usr/bin/env bash
# Install the host's VSCode extensions listed in hosts/$HOST/extensions.txt.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "$DOTFILES/bin/_lib.sh"

resolve_host

LIST="$HOST_DIR/extensions.txt"
[ -f "$LIST" ] || { echo "error: $LIST not found" >&2; exit 1; }

CLI=""
for c in code code-insiders codium code-oss; do
    if command -v "$c" >/dev/null 2>&1; then
        CLI="$c"
        break
    fi
done
[ -z "$CLI" ] && { echo "error: no VSCode CLI on PATH (tried code, code-insiders, codium, code-oss)" >&2; exit 1; }

echo "host: $HOST"
echo "using: $CLI"
while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"
    line="$(echo "$line" | xargs || true)"
    [ -z "$line" ] && continue
    "$CLI" --install-extension "$line" --force
done < "$LIST"
