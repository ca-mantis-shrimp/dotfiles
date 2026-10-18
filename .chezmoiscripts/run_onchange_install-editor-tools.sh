#!/bin/sh
# Language servers and linters that ship on npm, for nvim and agents, into ~/.local.
# chezmoi reruns this when the file changes, so a version bump here reinstalls.
# Release-binary servers are pinned in .chezmoiexternal.toml instead.
set -eu
npm install --global --prefix "$HOME/.local" \
  pyright@1.1.414 \
  bash-language-server@5.8.1 \
  vscode-langservers-extracted@4.10.0 \
  fish-lsp@1.1.5 \
  markdownlint-cli2@0.23.3
