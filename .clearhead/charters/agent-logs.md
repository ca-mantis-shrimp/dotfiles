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
- **Use `jq` for raw inspection and DuckDB for recurring queries.** `~/.config/otelcol/query.sql` defines views over the active and rotated JSONL files; load it with `duckdb -init ~/.config/otelcol/query.sql`.
- **Pi exports metrics through `@mobrienv/pi-otlp` over OTLP/HTTP on tailnet port 4318.** Chezmoi owns Pi's package list and the Fish environment that enables the exporter, so every managed machine targets `http://mini-travel-server:4318/v1/metrics`. Metrics are stored separately in `agent-metrics.jsonl` and exposed by the `pi_metrics` DuckDB view.
- **Pi transcripts remain Pi session JSONL.** `pi-otlp` exports session, turn, tool, token, cost, and duration metrics; it does not export prompts, responses, or historical session entries.
- **Every agent speaks OTLP/HTTP to port 4318.** The hub URL lives once in
  `.chezmoidata/telemetry.yaml`. Claude Code reads it from the `env` block of
  `~/.claude/settings.json`, so it exports no matter which shell, editor, or
  desktop entry launches it. Pi, opencode and Gemini CLI only read environment
  variables, so Fish exports them. `OTEL_RESOURCE_ATTRIBUTES` sets `host.name`.
  The collector retains each signal in separate rotated JSONL files. `agent_spans`
  provides a flat DuckDB span view; native OTLP JSON remains the source of truth.
  Do not enable prompt, assistant-response, tool-detail, or raw-API-body content
  gates by default: even redacted events carry identifying metadata, and content
  can include secrets.

## Local smoke test

Claude Code 2.1.282 emitted `claude_code.user_prompt`, `claude_code.api_request`,
and `claude_code.assistant_response` log events; `claude_code.interaction` and
`claude_code.llm_request` spans shared a trace ID; and `claude_code.*` metrics
arrived. The test used a single no-session-persistence prompt. It establishes
local ingest, not remote tailnet delivery or complete transcript capture.
A second, Read-only test emitted `claude_code.tool_decision` (accepted),
`claude_code.tool_result` (success), and a `claude_code.tool.execution` span.
They share the tool-use ID and trace ID with the interaction and model-request
spans. Without an explicit Read permission, the same test instead produced a
`claude_code.tool.blocked_on_user` span. The OpenLIT Compose experiment is
separate and does not own ports 4317/4318.

## Remaining Validation

- Power-cycle the hub and verify both the linger-started collector and Tailscale Serve rule return without an interactive login.
- Send Claude Code OTLP logs from another tailnet device and verify they appear in `agent_logs`.
