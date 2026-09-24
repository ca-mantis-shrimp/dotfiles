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

## Open Questions

- How much history do we keep? This sets the file exporter's `rotation:` values.
- Does `batch` earn its place for a single user writing to a local file?
- What's the query story beyond `jq`? For example, a `duckdb` view over the JSONL.
- Which machine is the hub: the desktop (always on) or the tiny server? The collector is currently installed on `mini-travel-server`.
