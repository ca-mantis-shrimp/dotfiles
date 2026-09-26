# Neovim workspace and session charter

## Intent

Build a disciplined workspace model for Neovim that matches how I actually work:

- `shada` stays global and keeps editor memory.
- project sessions are clone-local and live under the repo git dir at `<gitdir>/nvim/session.vim`.
- `~` is a neutral workspace, not an implicit project.
- entering or switching projects is explicit.
- `snacks.nvim` provides the project picker UI, but does not own session semantics.

This charter exists because raw Neovim sessions, views, and shada overlap just enough to be confusing, and because I often start Neovim or Neovide from `~` and later move into a project.

## Current config facts

The next agent should start from the real config, not from generic Neovim advice.

- Config root: `~/.local/share/chezmoi/dot_config/remove_nvim`
- `mini.sessions` is already enabled in `lua/plugins/platforms/mini.lua` with plain `require("mini.sessions").setup()`.
- `snacks.nvim` is enabled in `lua/plugins/platforms/snacks.lua`.
- Snacks project picker is already mapped on `<leader>sp` via `Snacks.picker.projects()`.
- Snacks dashboard currently includes a `Sessions` section.
- There is a `BufEnter` autocmd in `lua/config/autocmds.lua` that auto-runs `tcd` to a detected root.

That last point is important: automatic `tcd` on every buffer enter cuts against a clear workspace model. It silently changes tab cwd based on whatever buffer was entered most recently.

## Desired model

### State model

There are only two meaningful workspace states:

1. neutral state
2. active project state

Neutral state means:

- started in `~` or another non-project directory
- no project session is active
- no repo session should be auto-loaded or auto-saved

Active project state means:

- one repo is the active workspace for this Neovim instance
- its session file path is derived from the repo's actual git dir
- session save/load operations target only that repo session

Only one active project should exist per Neovim instance.

### Persistence split

- `shada`: global, leave it alone
- session: `<gitdir>/nvim/session.vim`
- views: ignore for now unless persistent folds are explicitly wanted later

Do not try to make sessions, views, and shada all manage the same cursor/fold/window concerns at once.

## Principles

1. Prefer explicit workspace transitions over clever automation.
2. Do not auto-switch projects just because a file from another repo was opened.
3. Do not key session ownership off raw `cwd`; use the resolved git dir.
4. Treat worktrees correctly: `.git` may be a file, not a directory.
5. Keep the implementation small and local. A thin custom workspace layer is better than bending several plugins into shape.
6. Do not let a project session accumulate buffers and tabs from unrelated repos.

## Recommendation on existing plugins

### `mini.sessions`

`mini.sessions` is useful as a thin session file wrapper because it already uses `:mksession` and respects `sessionoptions`.

But the current default setup is not enough for the desired workflow because the real need is workspace state management, not named global sessions.

Recommended direction:

- keep `mini.sessions` only if it can be used as the low-level read/write primitive
- disable or avoid features that imply global named sessions or default local `Session.vim` behavior
- if adapting `mini.sessions` becomes more complex than directly calling `:mksession`, remove it from this workflow

The next agent should decide quickly: adapt it cleanly, or bypass it. Do not build a hybrid mess.

### `snacks.nvim`

Use Snacks as the UI layer only:

- `Snacks.picker.projects()` selects a target project
- custom code performs the workspace transition

Do not let a dashboard session list or generic session picker redefine the session model.

## Proposed module layout

Add a small module, likely at:

- `lua/config/workspace.lua`

This module should own:

- active project state
- repo root resolution
- actual git dir resolution
- session path creation
- workspace save/load/close/switch behavior

Keep the logic centralized there instead of scattering it across plugin files.

## Core behaviors to implement

### 1. Git-aware path resolution

Implement helpers for:

- `find_repo_root(path)`
- `find_git_dir(path)`
- `session_path(path)` -> `<gitdir>/nvim/session.vim`

Use Git-aware resolution, not string concatenation with `<root>/.git`.

The implementation should work for:

- normal repos
- worktrees
- starting from a file path
- starting from a directory path

### 2. Active workspace state

Track at least:

- active repo root
- active git dir
- active session path
- whether current instance is in neutral mode

This can live in a Lua module table. No need for anything heavier.

### 3. Session save

Provide a function that:

- returns early in neutral mode
- ensures the parent directory for the session file exists
- writes the session to `<gitdir>/nvim/session.vim`

If `mini.sessions` is used, call its write primitive with an explicit path if possible.
If not, use `:mksession!` directly.

### 4. Session load

Provide a function that:

- resolves the target repo and session path
- loads the session if it exists
- otherwise sets cwd/tab cwd appropriately and starts clean
- marks that repo as the active workspace

### 5. Workspace clear/close

Provide a strict way to clear the current project workspace before opening another one.

Target behavior:

- save session first when appropriate
- prompt if there are modified buffers
- close project buffers/windows/tabs cleanly
- return to neutral state on close

Be strict first. Do not try to preserve miscellaneous help, scratch, terminal, and cross-project buffers until the base model is stable.

## User commands

Create explicit commands.

### `:ProjectOpen [path]`

Use when entering a project from neutral state.

Behavior:

- if no path is given, use current cwd if it is inside a repo
- resolve repo + git dir
- prompt before replacing an existing non-empty workspace
- load that repo session if present
- otherwise start a clean workspace rooted there

### `:ProjectSwitch [path]`

Behavior:

- save current active project session
- prompt if there are unsaved buffers
- clear current workspace
- open target project

This may delegate almost entirely to `ProjectOpen` after a save/clear step.

### `:ProjectClose`

Behavior:

- save current project session
- close the project workspace
- return to neutral state, preferably in `~`

### `:SessionSave`

Behavior:

- manually save the active project session
- no-op or notify if in neutral mode

### `:SessionQuit`

Behavior:

- save active project session
- write files
- quit all

This is the missing disciplined answer to "save and close everything while saving this".

## Autocmd policy

Autocmds should be sparse and boring.

### On `VimEnter`

Auto-load only when all of these are true:

- Neovim started with `argc() == 0`
- startup cwd is inside a git repo
- a session file exists for that repo

If startup happens in `~`, do nothing. That is neutral mode.

### On `VimLeavePre`

If a project is active, save its session.

### On `BufEnter`

Remove or substantially narrow the current auto-`tcd` behavior.

It is incompatible with explicit workspace ownership because it makes cwd follow whichever buffer happens to be active. That is exactly the kind of hidden state change this charter is trying to eliminate.

If a cwd helper remains at all, it should be workspace-aware and not mutate cwd opportunistically on every buffer enter.

## Snacks integration

The existing keymap is:

- `<leader>sp` -> `Snacks.picker.projects()`

The next agent should wire project selection into the workspace layer rather than leaving it as a plain picker.

Two acceptable approaches:

1. replace the mapping with a custom function that opens the Snacks picker and handles confirm by calling `ProjectOpen` or `ProjectSwitch`
2. keep the picker mapping and add a separate workspace-aware project picker command/key

Preference: option 1, if Snacks makes the confirm hook straightforward.

## Sessions section on Snacks dashboard

The dashboard currently shows a `Sessions` section.

That may conflict conceptually with the new repo-local workspace model if it points at generic global sessions.

The next agent should either:

- remove the dashboard session section for now, or
- replace it with something aligned to repo-local project sessions

Do not leave misleading UI in place.

## Files likely to change

- `~/.local/share/chezmoi/dot_config/remove_nvim/lua/config/autocmds.lua`
- `~/.local/share/chezmoi/dot_config/remove_nvim/lua/config/keymaps.lua`
- `~/.local/share/chezmoi/dot_config/remove_nvim/lua/plugins/platforms/mini.lua`
- `~/.local/share/chezmoi/dot_config/remove_nvim/lua/plugins/platforms/snacks.lua`
- new file: `~/.local/share/chezmoi/dot_config/remove_nvim/lua/config/workspace.lua`

Possibly also:

- `init.lua`, if module load order matters

## Suggested implementation order

1. Add `lua/config/workspace.lua` with pure helper functions and explicit state.
2. Implement `ProjectOpen`, `ProjectSwitch`, `ProjectClose`, `SessionSave`, and `SessionQuit`.
3. Replace the `BufEnter` auto-root autocmd.
4. Add startup and exit autocmds for the strict project-only rules.
5. Wire Snacks project picking into `ProjectOpen` or `ProjectSwitch`.
6. Revisit `mini.sessions` and the dashboard sessions section.

## Acceptance criteria

The implementation is correct when all of these are true:

1. Starting Neovide or Neovim in `~` does not load a project session.
2. Starting Neovim in a repo with no file args loads that repo session if it exists.
3. Project sessions are written under the repo's actual git dir at `nvim/session.vim`.
4. Switching projects does not leave repo A buffers and tabs in repo B's session.
5. `SessionQuit` saves the active project session and exits cleanly.
6. Opening one file from another repo does not silently redefine the current workspace.
7. Worktrees resolve to the correct git dir.

## Non-goals for the first pass

- persistent views/folds
- preserving random scratch/help/terminal buffers across project switches
- multi-project sessions in one Neovim instance
- session sync across machines
- building a large abstraction layer or plugin

## Final opinion

The main thing to avoid is pretending that sessions alone solve workspace management.

They do not.

The right design here is a tiny explicit workspace layer with clear state transitions, using Neovim sessions only as the persistence format.
