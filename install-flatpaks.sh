#!/bin/bash

CheckDependency () {
    if [ ! "$(which "$1" 2>/dev/null)" ]; then
        echo "Error: missing '$1'"
        ABORT=1
    fi
}

CheckDependency "flatpak"

if [ "$ABORT" ]; then
    echo "Aborting"
    exit 1
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

while IFS=$'\t' read -r -a app
do
    origin="${app[0]}"
    id="${app[1]}"
    arch="${app[2]}"
    branch="${app[3]}"
    echo "Install '$origin' '$id'"
    flatpak install --noninteractive -y "$origin" "$id/$arch/$branch"
done < flatpaks

