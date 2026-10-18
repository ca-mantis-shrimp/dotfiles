---
id: 01a0d1c7-a598-7046-8306-caf5345b3914
alias: chezmoi
state: Active
---
# chezmoi

## Log

- 2026-10-18T08:32+00:00 — 2026-10-18: Clojure toolchain for rwd in the user layer: Temurin JDK 25.0.4.1 (~/.local/lib/jdk, java linked into ~/.local/bin), Clojure CLI 1.12.6.1673 via its pinned installer, clojure-lsp, clj-kondo and cljfmt as pinned externals. Darrion chose Conjure; parinfer is gpanders/nvim-parinfer (pure Lua, no build). No treesitter parsers are installed on devbox at all, so Conjure uses its fallback form selection.
- 2026-10-18T08:36+00:00 — 2026-10-18: treesitter back on devbox: tree-sitter CLI 0.27.1 as a pinned external, nvim-treesitter (main) installs the parsers for every configured language at startup and updates them on PackChanged, and the .actions grammar builds from the platform checkout (it had never been compiled here, so .actions files had no highlighting).
