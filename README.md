# opencode-notification-skill

An [OpenCode](https://opencode.ai) agent skill that plays sounds and shows macOS desktop notifications when the agent needs your attention.

- **Ping** + alert when user input or permission is required
- **Tink** + alert when work is complete
- Fully configurable — sounds, alerts, and message text

## Requirements

- macOS (uses `afplay` and `osascript`)
- OpenCode

## Install

Clone the repo and run the install script:

```bash
git clone https://github.com/alesdrobysh/opencode-notification-skill.git
cd opencode-notification-skill
bash install.sh
```

The script copies these files into `~/.config/opencode/skills/notification/`:

| File | Description |
|---|---|
| `SKILL.md` | Skill definition — instructions for the agent |
| `notify.sh` | Script that plays sound and shows the alert |
| `config.json` | Your configuration (edit this to customize) |

OpenCode will discover the skill automatically on the next session.

## How it works

The skill instructs the agent to run `notify.sh input` before asking questions or requesting permissions, and `notify.sh done` when it finishes all work. The script fires a macOS notification banner and plays a system sound simultaneously via `osascript` and `afplay`.

## Configure

Edit `~/.config/opencode/skills/notification/config.json`:

```json
{
  "sound_enabled": true,
  "alert_enabled": true,
  "input_sound": "/System/Library/Sounds/Ping.aiff",
  "done_sound": "/System/Library/Sounds/Tink.aiff",
  "input_alert_title": "OpenCode",
  "input_alert_message": "User input required",
  "done_alert_title": "OpenCode",
  "done_alert_message": "Work complete"
}
```

| Key | Type | Description |
|---|---|---|
| `sound_enabled` | bool | Play audio cues |
| `alert_enabled` | bool | Show macOS notification banners |
| `input_sound` | string | Path to sound file for input/permission events |
| `done_sound` | string | Path to sound file for work-complete events |
| `input_alert_title` | string | Notification title for input events |
| `input_alert_message` | string | Notification body for input events |
| `done_alert_title` | string | Notification title for done events |
| `done_alert_message` | string | Notification body for done events |

Set `input_sound` / `done_sound` to `null` to fall back to system defaults (Sosumi / Glass).

**Available built-in macOS sounds** (all in `/System/Library/Sounds/`):
`Basso`, `Blow`, `Bottle`, `Frog`, `Funk`, `Glass`, `Hero`, `Morse`, `Ping`, `Pop`, `Purr`, `Sosumi`, `Submarine`, `Tink`
