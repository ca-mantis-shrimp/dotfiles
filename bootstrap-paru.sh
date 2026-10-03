#!/bin/sh

[ "${CHEZMOI_CONTAINER:-}" = "1" ] && exit 0
[ "${CHEZMOI_IMMUTABLE:-}" = "1" ] && exit 0
[ "$(id -u)" -eq 0 ] && exit 0

# OS images own package installation, including future Arch ParticleOS images.
[ -e /usr/lib/personal-os/immutable ] && exit 0
[ -e /run/ostree-booted ] && exit 0

# Only runs on mutable Arch; distro branding is an additional immutable guard.
[ -f /etc/arch-release ] || exit 0
[ -r /etc/os-release ] || exit 0
. /etc/os-release
[ "${ID:-}" = "arch" ] || exit 0
case "${ID_LIKE:-}" in *particleos*) exit 0 ;; esac

# Exit if an AUR helper is already installed
type paru >/dev/null 2>&1 && exit 0
type yay >/dev/null 2>&1 && exit 0

# Build and install paru from AUR
# Requires: base-devel, git (standard on any Arch base install)
# Must NOT run as root — makepkg refuses to build as root
TMPDIR=$(mktemp -d)
cd "$TMPDIR" || exit 1
git clone https://aur.archlinux.org/paru.git
cd paru || exit 1
makepkg -si --noconfirm
cd / && rm -rf "$TMPDIR"
