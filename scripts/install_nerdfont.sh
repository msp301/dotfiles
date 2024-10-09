#!/bin/sh

FONT_ARCHIVE="Noto.tar.xz"
DEST_DIR="/tmp/"
DEST="$DEST_DIR$FONT_ARCHIVE"
INSTALL_DIR="$HOME/.local/share/fonts/noto-sans-nerd/"

if [ ! -f "$DEST" ]; then
    curl -OL --output-dir "/tmp" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_ARCHIVE"
fi

if [ ! -f "$DEST" ]; then
    echo "Font file '$DEST' does not exist"
    exit 1
fi

mkdir -p "$INSTALL_DIR"
tar Jxvf "$DEST" --wildcards -C "$INSTALL_DIR" "NotoSans*NerdFont*-Regular.ttf"

