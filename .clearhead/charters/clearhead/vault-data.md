---
id: 01a114c4-6a2b-730b-88c9-7772eb1f5845
alias: vault-data
parent: clearhead
state: Active
---
# Clearhead data in the vault

Move the user workspace from `~/.local/share/clearhead` into the Obsidian vault at `~/Documents/knowledge_base/clearhead/`, so one Syncthing share carries notes and actions together on every machine.

## Decisions (2026-10-06)

- Nested, not mingled: clearhead owns `clearhead/` inside the vault; Obsidian may read it but should not write there.
- Syncthing is the transport; no git for this data. Never sync a `.git` directory with Syncthing.
- The data path is defined once in `.chezmoidata/` and templated into the clearhead config, khal, vdirsyncer and rclone. Four hardcoded copies is how the old path spread.
- Machine-local state stays out of sync: the vault `.stignore` excludes `clearhead/sync` and `clearhead/.clearhead.lock`. The old share already produced `sync/plans.sync-conflict-20260926-012034-JEAVVHE.json`.

## Hazard

`vdirsyncer.timer` runs every five minutes on mini-travel-server. If vdirsyncer points at the new path before the files are there, it sees an empty store and pushes deletions to Radicale. Stop the timer first; restart it only after `clearhead doctor` and a manual `vdirsyncer sync` check out.

## Out of scope

clearhead-core writes `sync/plans.json` and `.clearhead.lock` into the data root although the configuration spec gives machine state to `state_dir`. That is a product fix in clearhead-core, not here.
