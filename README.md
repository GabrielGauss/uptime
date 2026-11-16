# uptime

External uptime checks for MacroPulse and Norve (norve.dev), run by GitHub Actions every 10 minutes.

- Targets: [`targets.txt`](targets.txt) (`name | url | expected status`).
- A target counts as down after 3 failed attempts 10 s apart.
- Down: opens an issue labeled `down` (or comments on the open one). Recovery: closes it. Watch this repo to get the emails.
- Run history: the Actions tab.

Schedules on GitHub Actions can run late by several minutes under load; this is a coarse monitor, not an SLA.
