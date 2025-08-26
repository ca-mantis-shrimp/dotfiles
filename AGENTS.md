---
title: Agents Direction
description: Hand-written guidance for LLM agents working on the literate config
author: primary_desktop
categories: LLM
created: 2025-08-23T10:42:54-0800
updated: 2025-08-25T19:26:56-0800
version: 2.1.0
---
# Action Zone (Read This First)



## Golden Rules

- Edit only .norg. Never edit generated files (.fnl/.lua/.conf/.tmpl) directly.
- Prefer simple local #tangle targets; use symlinks for chezmoi destinations.
- Always run `chezmoi apply --dry-run` before applying changes.
- If the source of truth is unclear, stop and ask the human.
- For non-trivial changes, add a short ADR (why over what).


## 60-second Quick Start (one command per line)

```bash
git status
chezmoi status
rg -n "#tangle" literate_config | head -20
nvim literate_config/<target>.norg
:Neorg tangle current-file
:e <target>.fnl | :w   # only if fennel
:e <target>.lua | :w   # only if fennel
chezmoi apply --dry-run --verbose
chezmoi apply
# log a brief note in "Agent Learning Log" below
```


## Decision Tree (where to work)

- Is the target file generated? Yes → locate its .norg: `rg -n "#tangle.*<filename>" literate_config/`. No → should it be managed? If yes → create a .norg; else → ask human.
- Is this Neovim fennel? Yes → tangle → open .fnl :w → open .lua :w (stylua formats).
- Platform specific? Yes → use .tmpl with chezmoi conditionals; document them.
- Multiple outputs? Use the complex tangle map pattern.
- Unsure at any step? Ask human; do not proceed.


## Workflow Pipeline (minimal)

- Edit the .norg (update prose + code together).
- :Neorg tangle current-file.
- If fennel: open .fnl → :w → open .lua → :w.
- Ensure/verify symlink (don’t duplicate existing links).
- chezmoi apply --dry-run → apply when correct.


## Testing and Success Criteria

- Configs: tool validates syntax (if available); dry-run shows only intended changes.
- Neovim fennel: nvim starts clean; feature smoke test passes; stylua ran.
- systemd socket: socket active; client triggers service; logs clean.


## Performance Playbook (keep it tight)

- Scope searches to literate_config/ by default; prefer ripgrep.
- Avoid full-repo scans and mass tangling; operate on current file only.
- Parallelize read-only checks (status + rg) when possible.
- Prefer Unix sockets locally; SSH socket forwarding for remote access.
- Capture minimal logs needed for verification.


# Reference Zone (Details and Rationale)

Hello my robotic colleague, please consider this both your first source of direction, as well as your personal space to write notes and guidance for future robotic colleagues to know what they should know going forward.

If all goes well, even if you cant solve a problem, you can help the next LLM that is given the action you were given

The sections will go over topics that include:
- what tools to use
- how to properly build the workflow
- how I expect you to interact with the code base


# Quick Start - Your First 5 Minutes

Before diving into the philosophy, here's how to get oriented and make your first safe change:


## Step 1: Understand the Current State

```bash
# Check what chezmoi knows about
chezmoi status

# See the literate config structure
find literate_config -name "*.norg" | head -10

# Check for any pending changes
git status
```


## Step 2: Practice the Workflow (Safe Example)

Let's practice on a simple file that won't break anything. We'll add a comment to the git config:

```bash
# 1. Open the git norg file
nvim literate_config/git.norg

# 2. In neovim, find a safe place to add a comment
# 3. Add something like: # Added by agent on [date]
# 4. Save the file (:w)
# 5. Tangle it: :Neorg tangle current-file
# 6. Check what was generated: ls -la literate_config/
```


## Step 3: Understand File Relationships

Key patterns to recognize:
- `.norg` files are the source of truth (edit these)
- `.fnl` files are generated from norg (don't edit directly)
- `.lua` files are compiled from fennel (don't edit directly)
- Symlinks in the main repo point to generated files
- `chezmoi apply` copies from repo to actual system locations


## Step 4: Common Commands Reference

```bash
# In neovim with a .norg file open:
:Neorg tangle current-file
:Neorg export to-file <path>

# For fennel files (neovim config):
:e <file>.fnl | :w
:e <file>.lua | :w

# Testing and applying:
chezmoi apply --dry-run
chezmoi apply
chezmoi apply --force
```


## Step 5: Before You Break Things Checklist

- [ ] Is there already a .norg file for what I want to change?
- [ ] Did I read the existing norg file to understand current decisions?
- [ ] Am I editing the .norg file (not the generated file)?
- [ ] Did I test with `chezmoi apply --dry-run` first?
- [ ] Do I understand which other tools might be affected?


## Architecture Mental Model

```
.norg files → tangle → .fnl/.conf files → compile/symlink → chezmoi → applied config
�                                                                      ↓
�─────────────── feedback loop (test, iterate) ←──────────────────────┘
```


## When Things Go Wrong

Common issues and solutions:
- **Tangle command not found**: Make sure you're in a .norg buffer in neovim
- **Generated file looks wrong**: Check the #tangle directive in the .norg file
- **Symlink broken**: Use `find . -type l -exec test ! -e {} \; -print` to find broken links
- **chezmoi apply fails**: Check `chezmoi doctor` and `chezmoi status`
- **Fennel won't compile**: Check syntax, ensure nfnl is working with `:checkhealth`


# Context

What you need to know is that this is my private configuration for my home directory in any computer i might interact with including but not limited to:
- traditional x86 computers
    - both linux
    - and windows
- ARM devices like phones
- containers and virtual machines

Our hope is that we can have "one configuration to rule them all" which will be employable in any environment and I can immediately have all my tools ready.

This is also the site for a second, very special experiment involving you. See, I think that given the proper guidance, you can accomplish more than most would think, so the entire configuration (to the best im able) is REALLY located in the `literate_config` directory where each `*.norg` file contains not just the code for the file in question, but also a written explanation of how things work, why certain decisions were made, and even how to test and look for the changes we are making

all of this is enabled through a combination of `chezmoi` for home directory management, and `neorg` for literate config capabilities. You can read more about how we employ both in the literate config!

even this very document is exported from the literate_config folder so be sure to check it out to see the core source


# Goals

We want to create a space where we can configure all of our tools once and apply them everywhere, no more trying to tinker with the machine to get everything working at once.

This allows us to try new cool things with the config while putting it all together in a coherent way that makes composing different tools easy and fun!


# Workflow

To this end, you will work almost entirely from within the literate config folder. You will research the decisions made up until that point, along with any supporting files you may need to pull BEFORE making changes by understanding that this is a shared space and that many tools are interacting together so it is of utmost importance that the implications of a decision are thought out BEFORE we make any changes to the code.

In fact, I would ask that you air on the side of humility and ask any questions where you have any, again, BEFORE making updates to the repository so that changes that break the config are not put in haphazardly

more than that, you should also update the config file themselves WHENEVER YOU UPDATE A CODE SNIPPET to include the reasoning behind your decision and any extra notes that future users may want to know.

This is intended to be a garden where knowledge can grow, and this can only happen when we go out of our way to make ourselves understandable

in fact, it is even acceptable to put questions in the literate config so you can be clear about where you are not sure or where you dont know what a line is doing, this will help the next person/bot to understand where we have definitive knowledge and where we are just following a tutorial

so, the worklow goes like this:
1. you are given an action
2. you review the relevant `norg` files and any supporting information
3. you make a plan and ask questions to me about any ambiguity, making updates or changes to the norg files to alleviate confusion
4. then once you are ready you update the norg files to represent the new state you want
5. you will then tangle the norg file into an equivalent file in the same directory
6. if there is not a symlink already to the file in the rest of the repo, you also need to make it to ensure its picked up by the config
7. once you are sure the update is visible to chezmoi you can use `chezmoi apply` to actually apply the changes to the source state


# Deployment

Because of our very unique architecture we must be disciplined in how we handle the various steps:
1. `norg` files are considered the source of truth and all prose and code edits should go into them exclusively
2. then, we use the neovim command `:Neorg tangle current-file` while editing the norg buffer to actually "tangle" it to the desired file
3. For some tools (like neovim) where we actually generate fennel files which still need to be converted to lua, you need to actually open the file you generated and save it so that the new new lua file is generated 
4. then you open that new lua file and save it so that it can be formatted by `stylua`
5. that lua file is what will be actually used as the symlink in the chezmoi folders


## Concrete Deployment Example

Here's the exact sequence for a neovim plugin change:
```bash
# 1. Edit the norg file
nvim literate_config/neovim/plugins/navigation.norg

# 2. In neovim, make your changes, then:
:w                           # Save the norg file
:Neorg tangle current-file   # Generate the .fnl file

# 3. Open the generated fennel file
:e navigation.fnl            # Open in same neovim session
:w                           # Save to trigger nfnl compilation to .lua

# 4. Open the lua file to format it
:e navigation.lua            # Open the generated lua file
:w                           # Save to trigger stylua formatting

# 5. Ensure symlink exists (if this is a new file)
# Check: ls -la ../../dot_config/remove_nvim/lua/remove_plugins/
# Create if needed: ln -s ../../../literate_config/neovim/plugins/navigation.lua ../../dot_config/remove_nvim/lua/remove_plugins/navigation.lua

# 6. Apply the changes
chezmoi apply --dry-run      # Check what will change
chezmoi apply                # Actually apply
```

Again, chezmoi is the underlying system of this so be sure to familiarize yourself with how chezmoi handles the source state. In particular, you will notice that you get allot of information about the layout of the files just from looking at the layout of the repository since all chezmoi really does is clone the state of the repository to the target machine. Therefore, you can get allot of context about where i file should go/be just by looking at the hierarchy.

This will also be important when you are deploying so you know WHERE to symlink the file from and even where to put it because features like prefixes can be tricky at first

Once the symlink is created, you use the `chezmoi` cli to actually APPLY the changes. 
your bread-and-butter will be `chezmoi apply` with the `--force` flag if you are very confident the changes wont overwrite anything important 

This is also a git repo remember, so periodically `git push origin` and `git fetch` to make sure you have the latest versions. This is a personal config so you shouldnt be fighting with other people it would likely be config coming from other machines

for documentation like this, you will use the neovim command `Neorg export to-file ...` command to generate a markdown file which is subtly different than tangling


# Testing

While this is still experimental, I would like for you to simply be able to use the `mkosi` command to:
- create a vm according to the `mkosi.conf` file that contains the newest config
- from there, you will have a good playground to test whatever you need to make sure any changes got applied gracefully
- this also allows you to test changes BEFORE `chezmoi apply` ing them so work towards making that workflow seamless is worth its weight in gold

and ofcourse, that `mkosi` config should go into the literate config if it doesnt exist already

but either way you can also hand it off to me to test since much of this will be something I need to test with my eyes and fingers, so it is again disciplined to ask me to do something rather than trying to make a programmatic test first.

if you do make steps to test something in the literate config again that helps me remember and trust your work even if its not something i can run but something to run would be nice where possible or even again what i should be seeing if the configuration change is visual


# Agent Notes and Learnings

This section is for future agents to leave notes about what they learned, common pitfalls, and improvements to the workflow.


## File Discovery Patterns

When looking for existing config:
```bash
# Find which norg file controls a specific tool
grep -r "tool_name" literate_config/

# Find all tangle directives to see what files are generated
grep -r "#tangle" literate_config/

# Check for broken symlinks
find . -type l -exec test ! -e {} \; -print

# See what chezmoi would do without doing it
chezmoi apply --dry-run --verbose
```


## Source of Truth Checklist (Before Editing ANY File)

- [ ] Is this file generated? If yes, locate its .norg and edit only that.
- [ ] Search for a .norg source:
- `rg -n "#tangle.*<filename>" literate_config/`
- `find literate_config/ -iname "*<filename-without-ext>*"`
- [ ] If found in .norg, edit the .norg, NOT the generated file
- [ ] If uncertain, ASK THE HUMAN first before touching it
- [ ] For neovim: Never edit .lua or .fnl directly; regenerate from .norg
- [ ] For docs: Prefer "Neorg export to-file …" over hand-editing .md


## Common Gotchas Discovered

- The `:` is crucial in `:Neorg tangle current-file` - it's a neovim command, not a shell command
- Fennel files need to be opened and saved in neovim to trigger nfnl compilation
- Generated lua files need to be saved again to trigger stylua formatting
- Always check if symlinks exist before creating new ones
- The `.nvim.lua` file in literate_config sets `makeprg = "chezmoi apply"` so you can use `:make` in neovim
- Some norg files generate multiple output files - check the #tangle directives carefully


## Tangle Troubleshooting

Symptoms and fixes:
- **Empty generated file**: Ensure @code … @end blocks are closed correctly
- **Wrong/trimmed filename**: Check `#tangle` name (no leading hyphens, correct spelling)
- **File not created**: Run `:Neorg tangle current-file` in the .norg buffer

Verification steps:
```bash
# In the target directory after tangling
ls -la
# In the .norg file
grep -A 5 "#tangle" path/to/file.norg
```


## Workflow Improvements Identified

- Could create a neovim command to automate the tangle→compile→format pipeline
- Could add git hooks to ensure norg files are always committed as source of truth
- Could create a validation script to check for missing symlinks or broken tangle directives
- The mkosi.conf could be expanded to include chezmoi setup for better testing


## Systemd Socket Activation Pattern (On-Demand Services)

When you need on-demand startup:
1. Create a .socket unit (the "doorbell") to listen on a Unix socket or TCP port
2. Modify the .service unit:
- Use `StandardInput=socket`
- Ensure ExecStart uses the same address/path as the socket unit
1. Prefer activation via socket (omit the [Install] section in the service)
2. Have client services depend on the .socket, not the .service
3. Test:
- `systemctl --user status <unit>.socket`
- Connect a client; service should auto-start

Performance Decision (Local-first):
- Use Unix domain sockets for local connections (lower latency, secure by fs permissions)
- Use SSH socket forwarding for remote access (no direct TCP exposure)
- Document your choice and trade-offs

Reference:
- [Neovim server socket activation design](#literateconfigneovimservicesservicesnorgmd)


## Questions for Future Investigation

- How does the nfnl compilation exactly work? Is it triggered by file save or something else?
- Are there any tools that depend on specific formatting of the generated files?
- What's the best way to handle platform-specific config within the norg files?
- Should we create automation scripts for the common workflows?


## Tangle Directive Patterns Reference


Two main patterns for tangle directives discovered in the codebase:


### Simple Tangle (Most Common - 90% of files)

```norg
#tangle filename.ext
e language
ent here
```
@end

Examples: navigation.norg → navigation.fnl, kitty_config.norg → kitty.conf


### Complex Tangle (Multiple Outputs)

```norg
tangle: {
key1: path/to/file1
key2: path/to/file2

gle key1
e language
ent for file1
```
``` language
content for file2
```
@end

Example: git.norg generates both .gitignore and dot_gitconfig.tmpl


## File Type Workflow Matrix


Based on analysis of 33+ norg files with tangle directives:

 Source Type | Steps | Commands | Example |
|-------|----------|---------|
 Config files (conf, toml, etc) | 1 | `:Neorg tangle current-file` | kittyconf, hyprlandconf |
 Neovim plugins (fnl → lua) | 3 | `:Neorg tangle current-file` → open fnl → `:w` → open lua → `:w` | navigationnorg → navigationfnl → navigationlua |
 Shell scripts | 1 | `:Neorg tangle current-file` | nvim_paste_wslnorg → sh |
 Templates (tmpl) | 1 | `:Neorg tangle current-file` | Profileps1tmpl, configfishtmpl |


## Symlink Verification Commands


Current state: 17 neovim plugin files properly symlinked

```bash
# Check if symlinks exist for neovim plugins
-la dot_config/remove_nvim/lua/remove_plugins/

ind all symlinks in repo
d . -type l -ls

erify symlink targets exist (should return nothing if all good)
d . -type l -exec test ! -e {} \; -print

ount symlinked files
-la dot_config/remove_nvim/lua/remove_plugins/ | wc -l
```


## mkosi Testing Status


Current mkosi.conf is minimal but functional:
- Base Arch Linux with essential packages (base, linux, linux-firmware)
- Includes git, neovim, chezmoi for basic testing
- Creates /bin/bash symlink for compatibility
- Ready for expansion with more comprehensive testing setup

To use: `mkosi build` creates a test environment in ._mkosi.output_


## Platform-Specific Patterns


Template files use chezmoi conditionals for cross-platform support:

```
{{- if eq .chezmoi.hostname "USMINDARBURGES1" }}
k-specific config
else }}
sonal config
 end }}
```

Current platforms detected:
- USMINDARBURGES1 (work machine)
- Default (personal machines)

Template files found: 5 (.tmpl files for PowerShell, Fish, Aerc, etc.)


## Remote Access Patterns (Local-first tools)

- Optimize for local performance first (Unix socket)
- Expose remote access via SSH socket forwarding (no direct TCP exposure)
- Document both local and remote connection flows

SSH socket forwarding:
```bash
ssh -L /tmp/nvim-remote.sock:/home/<user>/.cache/nvim/server.pipe <user>@<host>
nvim --server /tmp/nvim-remote.sock --remote-ui
```


## Repository Health Check Commands


```bash
# Check chezmoi health
zmoi doctor

ee what would change without applying
zmoi apply --dry-run

heck git status
 status

erify all tangle directives
-n "#tangle" literate_config/ | wc -l  # Should be 33+

heck for missing symlinks in neovim plugins
-la dot_config/remove_nvim/lua/remove_plugins/ | grep -v "^total"
```


## Directory Structure and Organization Patterns


When creating new norg files, follow the logical conceptual hierarchy, not just tool categories:


### Good Directory Examples

- `shells/prompts/starship/` - prompts are a subcategory of shell tooling
- `neovim/neovide/` - neovide is a neovim GUI, not a terminal emulator
- `desktop_environments/hyprland/` - specific to that DE


### Bad Directory Examples

- `shells/starship/` - too generic, prompts deserve their own subcategory
- `terminal_emulators/neovide/` - wrong conceptual grouping


### Tangle Path Best Practices

Prefer local tangling:
```norg
#tangle config.toml  ✅
```

Over complex relative paths:
```norg
#tangle ../../dot_config/tool/config.toml  ❌
```

Then create symlinks from the local tangled file to the chezmoi destination.


### Norg Syntax Conventions

Internal cross-references:
```norg
{:$/path/to/file.norg:}[Link text]  ✅
```

External links:
```norg
{https://example.com}[Link text]  ✅
```

Emphasis:
```norg
*bold text*  ✅ (not **bold text**)
```


### Research Before Creating

Always check existing patterns:
```bash
# Find similar tools to understand directory structure
 literate_config/ -name "*similar_tool*"

eck existing tangle patterns
 -r "#tangle" literate_config/ | grep -v "\.norg:" | head -5

ok for established naming conventions
iterate_config/*/
```


### Content Structure Template

Every new norg file should include:
1. **Overview** - What the tool does and why we use it
2. **Configuration Philosophy** - Our approach and principles
3. **System Integration** - How it connects to other tools
4. **Current Configuration** - The actual config with tangle directive
5. **Testing** - How to verify it works
6. **References** - Links to docs and related configs


### Migration Workflow Checklist

When migrating unmanaged files to literate config:
- [ ] Research existing directory structure for similar tools
- [ ] Check if tool is already referenced in other norg files
- [ ] Use simple local tangle paths
- [ ] Document integration points with other tools
- [ ] Include testing and troubleshooting sections
- [ ] Use proper norg syntax for links and emphasis
- [ ] Verify symlinks are created correctly
- [ ] Test with `chezmoi apply --dry-run` before applying


## Command Reference Philosophy

- Prefer patterns and templates over exact commands
- Focus on workflow and intent; link official docs for details
- Keep examples brief and update them only when the workflow changes


## Architecture Decision Record (ADR) Template (REQUIRED for non-trivial changes)

- **Problem**: What are we solving? Why now?
- **Options**: (A/B/C) with short pros/cons
- **Decision (why)**: One sentence on why this fits principles
- **Trade-offs**: What we gave up (performance, complexity, portability, etc.)
- **Testing**: Commands and success criteria
- **Migration**: Steps from old state to new

Example (neovim server):
- Problem: Persistent neovim service wasted resources; wanted shared buffers on demand
- Options: TCP-only (simple), Unix-only (optimal local), dual services (complex)
- Decision: Unix socket + SSH socket forwarding (local-first)
- Trade-offs: Slightly more complex remote use; gained best local latency
- Testing: systemd socket status; client attach; journal logs


## Human-Bot Collaboration Guidelines

**Ask first when**:
- Changes affect multiple subsystems or core workflows
- There are security or performance trade-offs
- Source of truth is unclear

**Proceed (with doc updates) when**:
- Following established patterns
- Implementing a previously agreed design
- Adding documentation/tests/symlinks within existing conventions


## Session Handoff Checklist

- [ ] Record new learnings in this file
- [ ] Document incomplete work with a clear todo list
- [ ] Note open questions for future agents/humans
- [ ] Verify generated files and symlinks exist and point correctly
- [ ] `chezmoi status` shows intent; avoid unintentional changes


## Agent Learning Log



### 2025-08-24 - Neovim Socket Activation Implementation

- **Task**: Implemented on-demand neovim server with systemd socket activation
- **Architecture Decision**: Chose Unix domain sockets over TCP for local-first development model
- **Key Learning**: Socket activation requires careful coordination between .socket and .service units
- **Performance Rationale**: Unix sockets (~1-2μs) vs TCP localhost (~10-20μs) latency matters for text editor responsiveness
- **Remote Access Strategy**: SSH socket forwarding for weak nodes (phones, tablets) connecting to strong edges
- **Files Modified**: 
- `literate_config/neovim/services/services.norg` - Complete rewrite with socket activation architecture
- `neovim-server.socket` - New socket unit for on-demand activation
- `neovimServer.service` - Modified for socket activation with StandardInput=socket
- `neovideWindow.service` - Updated dependencies for socket-based startup
- **Symlink Management**: Created `neovim-server.socket` symlink in `dot_config/systemd/remove_user/`
- **Testing Commands**: 
- `systemctl --user status neovim-server.socket` - Check socket status
- `nvim --server ~/.cache/nvim/server.pipe --remote-ui` - Test local connection
- SSH socket forwarding: `ssh -L /tmp/nvim.sock:/home/user/.cache/nvim/server.pipe user@server`
- **Migration Path**: Stop old always-on service, enable socket unit, restart clients
- **Workflow Lesson**: Always check if files are generated from .norg before editing directly (violated this with AGENTS.md)


### 2025-08-23 - Initial Documentation Agent

- Explored 33+ norg files with tangle directives
- Confirmed symlink structure (17 neovim plugins properly linked)
- Verified chezmoi health (working tree dirty but functional)
- Identified two tangle patterns: simple (#tangle file) and complex (tangle: [key: path](key: path))
- Documented file type workflows: 1-step for configs, 3-step for fennel→lua
- Found platform-specific template patterns using chezmoi conditionals
- mkosi.conf exists but minimal - ready for expansion


### 2025-08-23 - Starship/Neovide Migration Agent

- Successfully migrated starship.toml and neovide config.toml to literate config
- **Key Learning**: Directory structure should follow logical conceptual hierarchy
- **Mistake Made**: Initially placed starship in `shells/starship/` instead of `shells/prompts/starship/`
- **Mistake Made**: Initially placed neovide in `terminal_emulators/neovide/` instead of `neovim/neovide/`
- **Best Practice Discovered**: Use simple local tangle paths (`#tangle config.toml`) over complex relative paths
- **Syntax Learning**: Proper norg cross-references use `{:$/path/to/file.norg:}[Link text]` format
- **Content Structure**: Every norg file should include Overview, Philosophy, Integration, Config, Testing, References
