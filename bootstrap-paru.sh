#!/bin/sh

# Only runs on Arch-based systems
[ -f /etc/arch-release ] || exit 0

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