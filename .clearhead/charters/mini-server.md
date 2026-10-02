---
id: 01a0fb15-b777-75a3-a048-7e0da5722a02
alias: mini-server
parent: workspace
state: Active
---
# Mini-server migration and storage

## Intent

Turn `mini-travel-server` into a dedicated headless server with reproducible
Fedora bootc OS updates and a tested rollback/recovery path. Keep OS build
configuration in this repository, user dotfiles in chezmoi, and intentions,
planning, handoff, and execution tracking in this project-local ClearHead charter
and its paired actions. Do not maintain another PLAN or next-steps document.

Prepare the two available 4 TB USB disks as persistent storage before
reinstalling the NVMe so they can hold migration backups. The server must boot
when USB storage is absent, but storage-dependent workloads and backup jobs must
refuse to run against an unmounted directory.

## Boundaries and safety gates

- **Planning only.** Prepare designs, backup manifests, and recovery procedures
  locally. Do not resume SSH inventory, VM testing, storage setup, backups,
  installation, or production reboots without a separate go-ahead.
- Do not wipe the mini-server until required data is inventoried, independently
  backed up, and restore-tested, and the replacement is ready.
- Obtain explicit approval for the exact disks before array creation, formatting,
  installation, or a production reboot. The owner confirms both USB disks are
  empty; this is not blanket approval to write them or the NVMe.
- Keep another independent copy of irreplaceable data. A mirror is not a backup,
  and both disks share a USB dock/hub and power failure domain.
- Arrange physical console access and rescue media; Tailscale alone is not a
  recovery plan. Disconnect USB storage during the eventual NVMe installation.
- Never bake credentials or machine identities into the OS image. Do not run
  cloned production Syncthing or Tailscale identities in a VM.
- Preserve SELinux enforcement. OS rollback does not restore mutable application
  data, configuration, or schemas; workload rollback needs separate backups.
- Start with manually approved updates; automate only after health checks,
  backups, and recovery are proven reliable.

## Current position

The minimal Fedora 44 image passed bootc lint and local UEFI VM tests, including
SSH, sudo, networking, SELinux, image switch/reboot/rollback, and persistence.
Real workload restoration and Tailscale enrollment still need testing.

USB identities and topology are recorded. Operator-provided SMART reports show
clean sector/error counters on both CMR drives. The owner has chosen to skip
extended self-tests and use those reports as the baseline for non-critical home
storage. Tests are optional, not an outstanding setup gate or a claimed pass.

Other privileged inventory remains outstanding. The current weekly backup writes
to a directory on the live NVMe and excludes `/home`; it is not an independent
migration backup. No migration backups have been made and no server configuration
or disks have been changed.

## Planning sequence

Task state lives in [mini-server.actions](mini-server.actions); completed and
cancelled history lives in
[mini-server.completed.actions](mini-server.completed.actions).

1. **Finish the storage design locally.** Proposed: mdadm RAID1, GPT member
   partitions, ext4, and `/srv/storage`. Specify exact members, assembly and
   monitoring, optional UUID-based mounting with bounded waits, and healthy,
   degraded, and absent-storage behavior. Fstab `nofail` alone is not the whole
   RAID boot policy. None of the creation choices is approved for execution.
2. **Agree what to retain.** Use the observed inventory to draft the manifest.
   Cover required home data, hidden configuration, secrets, custom tooling,
   modified/untracked/ignored Git state, local refs/stashes, linked worktrees,
   ClearHead conflict copies, both knowledge-base directories, and application
   state. Review caches, large Rust targets, old VMs, and `agent-pi`; no deletion
   or exclusion is approved yet. Mark privileged coverage gaps separately.
3. **Specify backups and recovery.** Select an independent second destination,
   protect credentials/encrypt sensitive backups as appropriate, and preserve
   ownership, ACLs, xattrs, hard links, and symlinks where required. Plan consistent
   database exports/snapshots/quiescing and coordinate active editing before final
   sync. Rootless subordinate ownership needs a tested restore/import method.
   Choose representative file, credential, Git/worktree, and application restores.
4. **Define eventual image changes.** RAID/monitoring tooling, optional storage
   assembly/mounts, fail-closed mount/filesystem guards, workload definitions,
   account/subordinate-ID policy, runtime secrets, registry/trust, and release
   workflow. Do not implement or rebuild yet. Future approved VM tests must cover
   restored workloads, fresh identities, SELinux, missing storage, network loss,
   console recovery, update/rollback, and mutable application recovery.
5. **Prepare the eventual migration procedure.** NVMe layout, downtime/final sync,
   restore ordering, physical recovery access/rescue media, and separate explicit
   installation approval. Prefer retaining the old installation if feasible.
   Disconnect USB storage during installation, then reassemble the existing
   array rather than recreating it. Keep old backups until stable.

## Future administrator-assisted inventory

These are reference commands for a separately approved operator pass, not an
instruction to run them now. SMART reports have already been supplied; the main
remaining sudo gap is root-owned state. Connect as `dab@mini-travel-server` and
authenticate to sudo normally. Never share passwords, tokens, private keys, or
full container inspect/configuration output.

### Root-owned containers

```sh
sudo podman ps -a --format '{{.Names}} | {{.Image}} | {{.Status}}'
sudo podman volume ls --format '{{.Name}} | {{.Driver}}'
sudo podman volume inspect --all \
  --format '{{.Name}} | {{.Mountpoint}} | {{.Driver}}'
```

Do not start workloads to populate a listing. Podman queries may initialize or
update runtime bookkeeping. If any containers exist, inspect their bind-mount
metadata in a targeted follow-up, without exposing environment variables/labels.

The installed `docker` command is a Podman wrapper and cannot independently
inventory old `/var/lib/docker`. Check for a real daemon without starting it:

```sh
sudo test -S /run/docker.sock && echo docker-socket-present
systemctl is-active docker.service docker.socket containerd.service
```

If a socket or old Docker data exists, record it for a targeted follow-up. Do not
delete that data or start a new daemon against it.

### Privileged sizes and ownership

```sh
sudo timeout 180 du -x -sh \
  /root /var/lib/radicale /var/lib/tailscale \
  /var/lib/docker /var/lib/containerd /var/lib/containers \
  /var/backups /mnt/fat32

sudo stat -c '%n | owner %U:%G | mode %a | type %F' \
  /etc/radicale /etc/radicale/config /etc/radicale/users \
  /var/lib/radicale /var/lib/tailscale \
  /etc/ssh /etc/sudoers /etc/sudoers.d \
  /etc/NetworkManager/system-connections
```

Missing paths, errors, and timeouts are findings, not reasons to create paths or
change permissions. Do not print password files, Tailscale state, private keys,
sudoers, connection credentials, or `/root` contents into shared output. This
limited pass will not complete the whole restore manifest by itself.

## Next-agent handoff

Start with this charter and use the CLI from the repository root:

```sh
clearhead show charter mini-server
clearhead read actions --charter mini-server --open-only --format ids
```

Technical facts live in [the image README](../../os/mini-server/README.md) and
[the data inventory](../../os/mini-server/INVENTORY.md), not in another planning
file. Revalidate time-sensitive image/support facts before a future approved
build. Preserve the `.md`, `.actions`, `.completed.actions`, and tool-managed
`.mini-server.json` together.

Mini-server changes in this checkout remain uncommitted. The validated local
image remains available, but the disposable VM, disks, password/config, registry,
and update tag were removed.
No VM or test registry is running. A future test needs fresh isolated artifacts;
do not look for retained test credentials.

ClearHead action lint has informational I001 findings for historical completed
rows imported from the original plan without completion dates. Do not invent
dates or normalize unrelated charters simply to silence diagnostics.

### Separate platform feedback

`~/Products/platform` has a Support Ergonomics action with stable alias
`deduplicate-cli-warnings`. It is now about routing background workspace-health
findings through doctor/explicit repair, not merely deduplicating stderr. Read
that repo's `AGENTS.md` and the action before continuing it. The installed
`clearhead_cli 0.2.1` printed three distinct identity warnings twice within one
successful invocation; its build revision was not matched to source. Keep
operation-blocking errors visible and avoid automatic identity repairs.

This session only edited the platform's `support.actions` and `support.md`, not
implementation or specifications. Those edits are now in platform commit
`2eb1b3d`; the platform checkout was clean at final handoff. The action is still
open. Keep that follow-up separate from migration and inspect current state
before making changes.

## Log

- 2026-10-01T22:29-07:00 — Local VM passed UEFI boot, SSH, sudo, SELinux,
  bootc switch/reboot/rollback and persistence. USB SMART reads need sudo.
  No mini-server disks, mounts or configuration have been changed.
- 2026-10-01T22:47-07:00 — Read-only scout: home is about 556 GiB with
  namespace-aware reads; 87 readable Git roots include local work and five
  chezmoi stashes. Rootless volumes persist despite no containers. Technical
  findings are in os/mini-server/INVENTORY.md; privileged reads need sudo.
- 2026-10-01T23:56-07:00 — Operator checklist prepared; now consolidated above.
- 2026-10-02T00:20-07:00 — SMART counters clean; extended tests pending.
- 2026-10-02T00:24-07:00 — Owner opts out of extended SMART tests.
- 2026-10-02T00:26-07:00 — Planning only; implementation awaits go-ahead.
- 2026-10-02T00:45-07:00 — Plan/handoff now live in this charter.
