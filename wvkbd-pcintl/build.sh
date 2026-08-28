#!/bin/bash

# Builds and installs wvkbd-pcintl: upstream wvkbd v0.20 compiled with the
# PC-style layout set in this directory. Requires the same build deps as
# wvkbd (wayland, xkbcommon, pangocairo) plus git.
#
# Upstream tag v0.20 can move. The commit SHA below is the reviewed snapshot.
# The binary is installed to ~/.local/bin as the user. There is no root make.

set -euo pipefail

WVKBD_REPO=https://git.sr.ht/~proycon/wvkbd
DEST="${XDG_BIN_HOME:-$HOME/.local/bin}/wvkbd-pcintl"

cd "$(dirname "$0")"

SRC="$(mktemp -d)"
trap 'rm -rf "$SRC"' EXIT

git clone "$WVKBD_REPO" "$SRC"
git -C "$SRC" checkout --detach 6b41504a0cb58fd1163fa44692398fbd61f8905f &&
cp layout.pcintl.h config.pcintl.h keymap.pcintl.h "$SRC/" &&
make -C "$SRC" LAYOUT=pcintl &&
test -f "$SRC/wvkbd-pcintl" &&
[[ "$(head -c 4 "$SRC/wvkbd-pcintl")" == $'\x7fELF' ]] &&
mkdir -p "$(dirname "$DEST")" &&
install -D -m 755 "$SRC/wvkbd-pcintl" "$DEST"

echo "Installed $DEST"
