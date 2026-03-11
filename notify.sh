#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$SKILL_DIR/config.json"

DEFAULT_INPUT_SOUND="/System/Library/Sounds/Sosumi.aiff"
DEFAULT_DONE_SOUND="/System/Library/Sounds/Glass.aiff"

read_config() {
  local key="$1"
  local default="$2"
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "$default"
    return
  fi
  local val
  val=$(python3 -c "
import json
with open('$CONFIG_FILE') as f:
    c = json.load(f)
v = c.get('$key')
print('' if v is None else v)
" 2>/dev/null || echo "")
  if [[ -z "$val" ]]; then
    echo "$default"
  else
    echo "$val"
  fi
}

read_config_bool() {
  local key="$1"
  local default="$2"
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "$default"
    return
  fi
  local val
  val=$(python3 -c "
import json
with open('$CONFIG_FILE') as f:
    c = json.load(f)
v = c.get('$key')
if v is None:
    print('$default')
else:
    print('true' if v else 'false')
" 2>/dev/null || echo "$default")
  echo "$val"
}

play_sound() {
  local sound_file="$1"
  if [[ -f "$sound_file" ]]; then
    afplay "$sound_file"
  fi
}

show_alert() {
  local title="$1"
  local message="$2"
  osascript -e "display notification \"$message\" with title \"$title\"" 2>/dev/null &
}

get_sound_file() {
  local event="$1"
  local custom_path
  custom_path=$(read_config "${event}_sound" "")

  if [[ -n "$custom_path" && -f "$custom_path" ]]; then
    echo "$custom_path"
    return
  fi

  case "$event" in
    input) echo "$DEFAULT_INPUT_SOUND" ;;
    done)  echo "$DEFAULT_DONE_SOUND" ;;
  esac
}

main() {
  local event="${1:-}"
  if [[ "$event" != "input" && "$event" != "done" ]]; then
    echo "Usage: notify.sh <input|done>" >&2
    exit 1
  fi

  local sound_enabled alert_enabled
  sound_enabled=$(read_config_bool "sound_enabled" "true")
  alert_enabled=$(read_config_bool "alert_enabled" "true")

  if [[ "$sound_enabled" == "true" ]]; then
    local sound_file
    sound_file=$(get_sound_file "$event")
    play_sound "$sound_file"
  fi

  if [[ "$alert_enabled" == "true" ]]; then
    local title message
    title=$(read_config "${event}_alert_title" "OpenCode")
    message=$(read_config "${event}_alert_message" \
      "$(if [[ "$event" == "input" ]]; then echo "User input required"; else echo "Work complete"; fi)")
    show_alert "$title" "$message"
  fi

  wait 2>/dev/null || true
}

main "$@"
