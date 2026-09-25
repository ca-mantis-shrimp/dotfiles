---
id: 01a0d1c6-6d1f-753e-9b87-d9e28af89de5
alias: agent-logs
parent: chezmoi
state: New
---
# Agent Log Hub

## Intent

One place, on hardware I own, where every LLM agent's logs land — whatever harness produced them, whichever device it ran on. The collector starts when the machine powers on and needs no login.

Done means: an agent on another tailnet device emits OTLP logs, and they show up as queryable JSON lines on the hub without me touching anything.

## Principles

1. **Local-first.** Logs are plain files on disk, queried with existing tools (`jq`, `duckdb`). No hosted backend.
2. **Tailscale is the access control.** The collector never listens on a public or LAN interface.
3. **chezmoi owns the config.** The unit and the collector config are chezmoi source, never hand-placed files.
4. **Use the stock binary.** We use the upstream `otelcol` distro as installed and don't build a custom collector until a missing component forces it.

## Decisions

- **User unit, not system unit.** The binary lives at `~/.local/bin/otelcol`, and linger is already enabled, so a user unit starts at boot without needing root.
- **Bind to `127.0.0.1:4317`; expose it with `tailscale serve --bg --tcp 4317`.** A user unit can't be ordered after the system's `tailscaled.service`, so binding directly to the tailnet IP would race at boot. Binding to `0.0.0.0` would expose the port on untrusted networks.
- **The unit goes in `dot_config/systemd/exact_user/`.** Because of the `exact_` prefix, chezmoi deletes any untracked unit in `~/.config/systemd/user/`.
- **The config lives at `~/.config/otelcol/config.yaml`.** It's validated with `otelcol validate` before each restart.
- **`mini-travel-server` is the hub.** It already has the collector binary and user lingering enabled, and its server role makes it the least surprising always-on target.
- **Retain at most 30 days and 20 rotated 100 MB files.** This bounds rotated history at roughly 2 GB while preserving enough time for retrospective debugging. Revisit after observing real traffic volume.
- **Do not batch yet.** For the initial low-volume, single-file pipeline, avoiding another buffer keeps failure and shutdown behavior straightforward. Add `batch` only if measured write or throughput pressure warrants it.
- **Use `jq` for raw inspection and DuckDB for recurring queries.** `~/.config/otelcol/query.sql` defines `agent_log_exports` and a flattened `agent_logs` view over the active and rotated JSONL files; load it with `duckdb -init ~/.config/otelcol/query.sql`.

## Remaining Validation

- Power-cycle the hub and verify both the linger-started collector and Tailscale Serve rule return without an interactive login.
- Send Claude Code OTLP logs from another tailnet device and verify they appear in `agent_logs`.
