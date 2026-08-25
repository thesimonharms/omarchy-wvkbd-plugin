#!/bin/bash

# Builds and installs wvkbd-pcintl: upstream wvkbd v0.20 compiled with the
# PC-style layout set in this directory. Requires the same build deps as
# wvkbd (wayland, xkbcommon, pangocairo) plus git.

set -euo pipefail

WVKBD_REPO=https://git.sr.ht/~proycon/wvkbd
WVKBD_VERSION=v0.20

cd "$(dirname "$0")"

SRC="$(mktemp -d)"
trap 'rm -rf "$SRC"' EXIT

git clone --depth 1 --branch "$WVKBD_VERSION" "$WVKBD_REPO" "$SRC"
cp layout.pcintl.h config.pcintl.h keymap.pcintl.h "$SRC/"
make -C "$SRC" LAYOUT=pcintl

# make install needs root; pkexec works from a graphical session without a terminal
pkexec sh -c "cd '$SRC' && make LAYOUT=pcintl install"

echo "Installed $(command -v wvkbd-pcintl)"
