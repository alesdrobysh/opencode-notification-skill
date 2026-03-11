#!/usr/bin/env bash
set -euo pipefail

SKILL_DEST="$HOME/.config/opencode/skills/notification"
AGENTS_DEST="$HOME/.config/opencode/AGENTS.md"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -d "$SKILL_DEST" ]]; then
  echo "Already installed at $SKILL_DEST"
  echo "To reinstall, remove that directory first:"
  echo "  rm -rf \"$SKILL_DEST\""
  exit 1
fi

mkdir -p "$SKILL_DEST"
cp "$SCRIPT_DIR/SKILL.md"    "$SKILL_DEST/SKILL.md"
cp "$SCRIPT_DIR/notify.sh"   "$SKILL_DEST/notify.sh"
cp "$SCRIPT_DIR/config.json" "$SKILL_DEST/config.json"
cp "$SCRIPT_DIR/logo.png"    "$SKILL_DEST/logo.png"
chmod +x "$SKILL_DEST/notify.sh"

# Install global AGENTS.md (the agent instructions loaded every session)
if [[ -f "$AGENTS_DEST" ]]; then
  printf '\n' >> "$AGENTS_DEST"
  cat "$SCRIPT_DIR/AGENTS.md" >> "$AGENTS_DEST"
  echo "Appended notification instructions to $AGENTS_DEST"
else
  cp "$SCRIPT_DIR/AGENTS.md" "$AGENTS_DEST"
  echo "Installed agent instructions to $AGENTS_DEST"
fi

echo ""
echo "Installed skill to $SKILL_DEST"
echo "OpenCode will pick it up on the next session."
echo ""
echo "To configure, edit:"
echo "  $SKILL_DEST/config.json"
