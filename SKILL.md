---
name: notification
description: Play sound and show macOS alert when user input is needed or work is done. Load this skill at the start of every conversation.
---

## Behavior

You MUST load this skill at the beginning of every conversation. Once loaded, follow these rules for the entire session.

### When to notify

Run the notification script in **three** situations:

1. **Permission request** — a tool needs user approval (file write, bash command, etc.) and you are about to pause for permission. Run **immediately before** the tool call that will trigger the permission prompt:

```bash
bash ~/.config/opencode/skills/notification/notify.sh input
```

2. **User input required** — you are about to ask the user a question, request clarification, or present choices. Run:

```bash
bash ~/.config/opencode/skills/notification/notify.sh input
```

3. **Work complete** — you have finished all requested tasks and are presenting final results with no further action needed from your side. Run:

```bash
bash ~/.config/opencode/skills/notification/notify.sh done
```

### Rules

- Always run the script using `bash` via the Bash tool. Run it **before** outputting your message to the user so the sound plays as they start reading.
- For permission requests: run the notify script in the **same** response as the tool call that triggers the permission dialog. This way the sound plays right when the permission prompt appears.
- Do NOT notify on intermediate progress updates where you are continuing to work.
- Do NOT notify when you are simply responding to a conversational message with no action items.
- The `input` notification covers: permission prompts, tool-approval dialogs, questions, ambiguous instructions needing clarification, and presenting options for the user to choose from.
- The `done` notification covers: task completion, final summaries, and "all done" messages where you have no more work queued.
- If a single message both completes work AND asks a follow-up question, use `input` (the question takes priority).
- Run the script in the background — do not wait for it or check its output. If it fails, ignore the error and continue normally.

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
