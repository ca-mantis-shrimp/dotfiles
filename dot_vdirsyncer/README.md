# ClearHead calendar synchronization

This host composes ClearHead's VTODO vdir with the local Radicale CalDAV
service through vdirsyncer.

```text
calendar/task clients
        ↕ CalDAV
Radicale at localhost:5232
        ↕ CalDAV
vdirsyncer pair `plans`
        ↕ filesystem
~/.local/share/clearhead/plans/<charter>/
        ↕
clearhead sync calendar
        ↕
~/.local/share/clearhead/charters/
```

The full operational recipe is maintained in the
[ClearHead CLI cookbook](https://github.com/ClearHeadToDo-Devs/clearhead-cli/blob/master/docs/cookbook/radicale-vdirsyncer.md).

## Boundaries

- ClearHead accesses only `~/.local/share/clearhead/plans/`.
- vdirsyncer is the only process bridging that vdir to CalDAV.
- Radicale owns `/var/lib/radicale`; never point ClearHead at it or edit it as a
  vdir.
- Project-local `.clearhead/plans/` directories are intentionally not synced.
- Every immediate child of the global plans directory is a charter-scoped
  CalDAV collection.

## Credentials

The `backup-admin` Radicale password is read from the existing `pass` contract:

```sh
pass radicale/password
```

Provision it interactively without putting the value in chezmoi:

```sh
pass insert radicale/password
```

The systemd pre-cache unit reads this entry before synchronization so the GPG
agent can prompt once and retain the unlocked key according to
`~/.gnupg/gpg-agent.conf`.

## First setup

The Arch packages `pass`, `radicale`, and `vdirsyncer` are tracked in chezmoi's
package data. After installing packages and applying chezmoi:

```sh
chezmoi apply ~/.vdirsyncer/config \
  ~/.config/systemd/user/vdirsyncer-precache.service \
  ~/.config/systemd/user/vdirsyncer.service \
  ~/.config/systemd/user/vdirsyncer.timer
systemctl --user daemon-reload
```

The system Radicale service must be configured and active:

```sh
systemctl status radicale
```

Then discover and inspect collection mappings before seeding:

```sh
vdirsyncer discover plans
vdirsyncer sync plans
clearhead read plans
```

Do not reset unrelated Radicale collections. This pair is bidirectional and
intentionally has no blanket `a wins` or `b wins` transport policy.

### Adding a charter collection

vdirsyncer records discovered collections. When ClearHead first creates a
VTODO under a new charter directory, approve the corresponding Radicale
collection before the timer can transport it:

```sh
vdirsyncer discover plans
vdirsyncer sync plans/<charter-slug>
```

Discovery is deliberately not part of the unattended timer because creating a
remote collection is an administrative decision.

## Manual acceptance

Run one complete cycle manually before enabling the timer:

```sh
vdirsyncer sync plans
clearhead sync calendar --dry-run
clearhead sync calendar
vdirsyncer sync plans
```

Verify both directions with a VTODO-capable client, including priority,
categories, cancellation, and an arbitrary client-generated UID.

## Timer

The user timer runs the required three-stage sequence every five minutes:

```sh
vdirsyncer sync plans
clearhead sync calendar
vdirsyncer sync plans
```

Enable it only after manual acceptance succeeds:

```sh
systemctl --user enable --now vdirsyncer.timer
systemctl --user list-timers vdirsyncer.timer
```

Inspect failures instead of deleting synchronization state or forcing a winner:

```sh
systemctl --user status vdirsyncer.service
journalctl --user -u vdirsyncer.service
```
