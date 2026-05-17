# vdirsyncer — Calendar Sync

Syncs local clearhead plan calendars to Google Calendar via CalDAV.

## Data Flow

```
clearhead-cli
  writes .ics files
       │
       ▼
~/.local/share/clearhead/plans/<charter-slug>/
       │
       ▼ (vdirsyncer sync plans)
Google Calendar (clearhead-test)
       │
       ▼ (khal reads via discover)
khal / any CalDAV client
```

## Scope

Only the **global clearhead data directory** is synced:

```
~/.local/share/clearhead/plans/
```

Project-local workspaces (`.clearhead/plans/` inside a project directory) are intentionally outside this boundary. They are development artifacts, not personal schedule data.

## Charter → Google Calendar Mapping

Each subdirectory under `plans/` is a separate calendar collection. Mappings are explicit in `config`:

```toml
collections = [["local-name", "local-collection-id", "google-calendar-id"]]
```

Current mappings:

| Local dir        | Google Calendar |
|------------------|-----------------|
| `reflections`    | clearhead-test  |

### Adding a new charter

1. Edit `~/.local/share/chezmoi/dot_vdirsyncer/config`
2. Add a collection tuple to the `plans` pair:
   ```
   ["new-charter", "new-charter", "google-calendar-id@group.calendar.google.com"]
   ```
   Google Calendar must already exist (Google's CalDAV API does not support creating calendars programmatically).
3. `chezmoi apply ~/.vdirsyncer/config`
4. `vdirsyncer discover plans`
5. `vdirsyncer sync plans`

## Syncing

A systemd user timer runs the sync hourly (with up to 5 minutes of random jitter):

```sh
systemctl --user status vdirsyncer.timer   # check schedule
systemctl --user start vdirsyncer.service  # run immediately
journalctl --user -u vdirsyncer.service    # view logs
```

To run manually outside the timer:

```sh
vdirsyncer sync plans
```

## Conflict Resolution

Local wins (`a wins`). clearhead is the source of truth for plan data. Google Calendar is a read view.
