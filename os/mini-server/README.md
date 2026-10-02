# mini-server bootc image

This is the narrow, non-secret build context for `mini-travel-server`. Build it
from this directory. Never add credentials, SSH private keys, Tailscale state,
home-directory contents, or application data.

Intentions, task state, operator planning, approvals, and the next-agent handoff
live in [the project-local ClearHead charter](../../.clearhead/charters/mini-server.md).
This document records technical build/reference information and test results.

## Base image

The image uses Fedora bootc 44, pinned to the multi-architecture OCI index:

```text
quay.io/fedora/fedora-bootc:44@sha256:62e0fe047be7b9c00abab3911fc84f8a22b2b2e097a6ca76119ebe395a6da3bf
```

The pin was resolved on 2026-10-01. Fedora 44 was the current `latest` release;
Fedora 45 was also published and Fedora 46 was `rawhide`. Using the numbered tag
avoids an accidental major-release change, while the digest makes rebuilds
intentional and reproducible.

Before refreshing it:

1. Check the [Fedora lifecycle](https://docs.fedoraproject.org/en-US/releases/lifecycle/)
   and [Fedora bootc documentation](https://docs.fedoraproject.org/en-US/bootc/).
2. Inspect the numbered tag and record its OCI index digest:
   `skopeo inspect --raw docker://quay.io/fedora/fedora-bootc:44 | sha256sum`.
3. Review package/configuration changes, update both `FROM` and this document,
   build, and complete the VM update/rollback tests.
4. Treat a change from Fedora 44 to 45 as a separately reviewed upgrade.

Tailscale uses its official stable Fedora repository. Its repo file is tracked
under `files/`; RPM and repository signature checks remain enabled.

## Current host inventory (read-only, 2026-10-01)

No host configuration, mounts, containers, or disks were changed.
See [the detailed data inventory](INVENTORY.md) for home/Git recovery risks,
namespace-aware container-volume sizes, and coverage limitations. Future operator
checks and migration gates are in the ClearHead charter, not this build context.

- `dab` is a conventional UID/GID 1000 account from NSS with `/home/dab` and
  `/bin/fish`; `homectl` has no home record for it.
- Required running system services appear to be SSH, Tailscale, Radicale, and
  `syncthing@dab`. Desktop services (LightDM, Bluetooth, Bolt, audio/session
  components) are not required for the target image.
- Radicale runs as `radicale`, uses `/var/lib/radicale`, and authenticates from
  `/etc/radicale/users` using htpasswd. Back up both paths, including ownership
  and SELinux labels. Collection contents could not be inspected without sudo.
- Syncthing state is under `/home/dab/.local/state/syncthing`. It has three
  send/receive folders: `~/gym`, `~/Documents/knowledge_base`, and
  `~/.local/share/clearhead`, shared with two remote devices. Preserve
  `config.xml`, `cert.pem`, and `key.pem`; never commit them.
- User services include an OpenTelemetry Collector using
  `~/.config/otelcol/config.yaml`, Neovim listening on all interfaces at port
  6666, and a vdirsyncer timer. Decide whether Neovim and vdirsyncer survive.
- Relevant listeners include SSH 22, Radicale 5232 (loopback), Syncthing 8384
  (loopback) and 22000/21027, Tailscale, OTLP 4317/4318, and Neovim 6666.
  OTLP and Radicale are also exposed through Tailscale. Recreate only deliberate
  exposure and do not expose Neovim publicly by default.
- The 954 GiB NVMe contains the live EFI, swap, and ext4 root filesystems. Two
  4 TB disks are unmounted; one has an ext4 filesystem. The owner confirms both
  are empty/available for storage; array creation still requires explicit approval.
- Passwordless sudo is unavailable. Root-owned/stopped containers, firewall
  rules, the complete Radicale state, and privileged disk details still require
  an administrator-assisted inventory.

### USB storage inspection

Read-only SSH inspection identified two equal-capacity 4 TB, 512-byte logical /
4096-byte physical sector drives:

- WD40EFPX-68C6CN0, serial `WD-WX22D55EMYVE`, WWN `0x50014ee2c187373e`;
- WD40EZAX-00C8UB0, serial `WD-WX52D847K1PS`, WWN `0x50014ee21684b72b`.

Both use UAS at 5 Gbit/s through the same VIA USB hub and NS-PCHDEDS19 dock.
The USB bridge serial is duplicated between bays; use drive ATA/WWN identifiers,
not the bridge serial or `/dev/sdX`, when selecting array members. No disconnect,
reset, or I/O error appeared in the filtered current-boot storage log. Operator
SMART reports supplied on 2026-10-02 show both drives as CMR with zero
reallocated/pending/uncorrectable sectors, zero CRC errors, and no logged errors.
Temperatures were 32/33 degrees C and power-on hours 2944/8615 respectively.
The USB bridge omits ATA status registers, so the reported health pass is only
attribute-based. No self-tests have been logged. The owner accepts that remaining
uncertainty for non-critical home storage and has chosen to skip extended tests;
they are optional rather than a setup gate. Approval/task state is in ClearHead.

`mdadm` and `smartctl` are installed on Arch. RAID1 is a proposed design, not an
existing array. Health checks and explicit disk-write approval must precede
creation. Shared USB/power infrastructure remains a common failure point, so
keep an independent copy of irreplaceable migration data.

### Backup blocker

The weekly `rsync-usb-system-backup` job is **not an independent backup**.
`/mnt/fat32` is not a mount point; it is a directory on the live NVMe root. The
job writes approximately 126 GiB back onto that same filesystem and explicitly
excludes all of `/home`, including every Syncthing folder and its identity. Do
not rely on this job for migration or recovery. Do not delete that directory
until its contents have been reviewed with administrator access.

Required preservation candidates and ownership constraints are recorded in
[INVENTORY.md](INVENTORY.md). The actual backup manifest, restore-test choices,
and approvals are tracked in ClearHead.

## Build and inspect

The initial image was built on 2026-10-01. All listed packages resolved, the four
host services were enabled, and `bootc container lint --fatal-warnings` passed
(14 checks passed, one inapplicable check skipped). The VM results below validate
basic bootability, but not the complete migration procedure.

The retained local Docker tag is `mini-server:validation`, image digest:

```text
sha256:20261f8f7feb049d490582476e6c1688efa46b6d243a0ee8058b4575ca2f4e0b
```

Use rootful Podman on an SELinux-capable Fedora builder:

```sh
cd os/mini-server
sudo podman build --pull=never -t localhost/mini-server:dev .
sudo podman run --rm localhost/mini-server:dev bootc container lint
sudo podman history --no-trunc localhost/mini-server:dev
```

`--pull=never` enforces use of the already reviewed digest. Pull that exact base
explicitly first when refreshing the local cache. Review image history and a
saved-image file listing before publishing. The initial registry, trust policy,
and release naming scheme are still undecided, so this image must not yet be
published or deployed.

## Accounts and first access

The image deliberately contains no `dab` account or authorized key. Supply the
UID/GID 1000 account and a public SSH key through an untracked
`bootc-image-builder` installation config (or another reviewed first-boot
mechanism). Keep its config outside this repository if it contains a password
hash or identifying key. The VM confirmed that a key-only wheel account cannot
use sudo: provide a strong password hash as well, or define another intentional
recovery policy. Never put the plaintext password in the config.

After first boot, enroll Tailscale interactively with `tailscale up`; never use
an auth key in the image. Restore Syncthing data before enabling
`syncthing@dab.service`. Restore Radicale with the service stopped and apply
correct ownership and SELinux labels (`restorecon -RFv` on restored paths).

## VM validation results (2026-10-01)

A disposable 10 GiB XFS QCOW2 was generated with `bootc-image-builder` and
booted under QEMU/KVM with UEFI firmware, 2 GiB RAM, and two virtual CPUs. The
builder needed `--rootfs xfs` because this Fedora base does not declare a default
root filesystem. The tested builder image was:

```text
quay.io/centos-bootc/bootc-image-builder@sha256:2b52843ea2bfda73b0a08d97e76b734393b1d3a804681b9fabb26723bd3a2f0b
```

It used a separately populated Podman storage directory and an untracked
installation config. The builder printed overlay-unmount and compiled-SELinux
regex-version warnings, but installation completed and the guest booted with
SELinux enforcing.

Passed:

- UEFI boot, DHCP networking, SSH public-key login, UID/GID 1000 `dab`, and sudo
  using the untracked installation-time password hash;
- SELinux enforcing, rootless Podman using overlayfs, firewalld allowing SSH, and
  no failed systemd units;
- active NetworkManager, firewalld, sshd, and tailscaled services;
- installed Syncthing and Tailscale binaries, with Tailscale intentionally logged
  out and no production identity copied;
- persistence across an ordinary reboot: `/home` is a link to `/var/home`, and
  the test file under `/var/home/dab` survived;
- `bootc switch` to a second image, reboot into that deployment, and verification
  of its immutable `/usr` marker;
- `bootc rollback`, reboot back to the original digest, and removal of the second
  image's marker; and
- preservation of both `/var/home` data and a local `/etc` override across the
  update and rollback.

Still untested: Tailscale enrollment, restored Radicale/Syncthing data, workload
containers, `/etc` merge conflicts, network-loss recovery, and application data
rollback. The VM used only synthetic state and a newly generated test password;
no mini-server identity or application data was copied.

The disposable VM, disk files, temporary password/config, local registry, and
update test tag were removed. No test VM or registry remains running; only the
validated base tag is retained. No production identity or data was copied.

For future approved test procedures, use the current
[`bootc-image-builder` documentation](https://osbuild.org/docs/bootc/). Remaining
validation actions and deployment/recovery gates live in the ClearHead charter
and actions; past test success is not approval for further operations.
