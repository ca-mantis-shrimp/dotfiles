# Mini-server OS project moved

Canonical OS source, migration planning and the next-agent handoff now live in
the local ParticleOS-derived fork at **`~/Products/personal-os`**.

Start the next session there with `AGENTS.md`, the root README and
`.clearhead/charters/mini-server.md` plus its paired actions. The charter identity,
history, inventory and bootc prototype were preserved; the prototype is now
`reference/bootc/` in that repository. Do not continue OS implementation or create
a second migration plan here.

This repository remains the user-configuration source and is pinned as the
fork's `dotfiles/` submodule. The build stages committed chezmoi source; automatic
target-side initialization/application happens after build, not on the builder.

The fork is local and not yet a deployable image or public release. Migration
file removals and this forwarding README remain uncommitted in this dotfiles
checkout for review; no unrelated work was committed or reset.
