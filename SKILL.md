---
name: notification
description: Play sound and show macOS alert when user input is needed or work is done. Load this skill at the start of every conversation.
---

## Behavior

The notification instructions are automatically loaded via `~/.config/opencode/AGENTS.md` in every session. This skill exists for configuration reference only.

If for some reason the agent has not already been instructed to send notifications, follow these rules:

### Configuration

The user can edit `~/.config/opencode/skills/notification/config.json` to customize behavior:

| Key | Type | Default | Description |
|---|---|---|---|
| `sound_enabled` | bool | `true` | Play audio cues |
| `alert_enabled` | bool | `true` | Show macOS desktop notifications |
| `input_sound` | string/null | `null` | Path to custom sound file for input events |
| `done_sound` | string/null | `null` | Path to custom sound file for done events |
| `input_alert_title` | string | `"OpenCode"` | Notification title for input events |
| `input_alert_message` | string | `"User input required"` | Notification body for input events |
| `done_alert_title` | string | `"OpenCode"` | Notification title for done events |
| `done_alert_message` | string | `"Work complete"` | Notification body for done events |

If the user asks to change notification settings, edit this JSON file directly.

### Sound defaults

- **Input**: Ping (`/System/Library/Sounds/Ping.aiff`)
- **Done**: Tink (`/System/Library/Sounds/Tink.aiff`)

Override these by setting `input_sound` / `done_sound` in config.json to any `.aiff`, `.wav`, or `.mp3` file path.
