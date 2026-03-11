## Notifications

Run the notification script in **three** situations:

1. **Permission request** — a tool needs user approval and you are about to pause for it. Run **immediately before** the tool call that will trigger the permission prompt:

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
- Do NOT run the `done` notification if you are a subagent — only the top-level agent talking directly to the user should fire `done`.
- The `input` notification covers: permission prompts, tool-approval dialogs, questions, ambiguous instructions needing clarification, and presenting options for the user to choose from.
- The `done` notification covers: task completion, final summaries, and "all done" messages where you have no more work queued.
- If a single message both completes work AND asks a follow-up question, use `input` (the question takes priority).
- Run the script in the background — do not wait for it or check its output. If it fails, ignore the error and continue normally.
