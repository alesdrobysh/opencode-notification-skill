#!/usr/bin/env bash
set -euo pipefail

DEST="$HOME/.config/opencode/skills/notification"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -d "$DEST" ]]; then
  echo "Already installed at $DEST"
  echo "To reinstall, remove that directory first:"
  echo "  rm -rf \"$DEST\""
  exit 1
fi

mkdir -p "$DEST"
cp "$SCRIPT_DIR/SKILL.md"   "$DEST/SKILL.md"
cp "$SCRIPT_DIR/notify.sh"  "$DEST/notify.sh"
cp "$SCRIPT_DIR/config.json" "$DEST/config.json"
cp "$SCRIPT_DIR/logo.png"   "$DEST/logo.png"
chmod +x "$DEST/notify.sh"

echo "Installed to $DEST"
echo "OpenCode will pick it up on the next session."
echo ""
echo "To configure, edit:"
echo "  $DEST/config.json"
