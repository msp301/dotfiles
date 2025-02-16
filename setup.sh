#!/bin/sh

IMAGE=devbox
CONTAINER=dev
SOCKET_SERVICE=podman.socket
PODMAN=podman

CheckDependency () {
    if [ ! "$(which "$1" 2>/dev/null)" ]; then
        echo "Error: missing '$1'"
        ABORT=1
    fi
}

ResolvePodman () {
    if [ "$(which "podman-remote" 2>/dev/null)" ]; then
        PODMAN=podman-remote
    fi
}

ResolvePodman
CheckDependency "$PODMAN"
CheckDependency "toolbox"
CheckDependency "systemctl"

if [ "$ABORT" ]; then
    echo "Aborting"
    exit 1
fi

systemctl is-active --quiet "$SOCKET_SERVICE"
if [ $? -ne 0 ]; then
    systemctl --user enable "$SOCKET_SERVICE"
    systemctl --user start "$SOCKET_SERVICE"
fi

CONTAINER_ID="$($PODMAN ps -q --filter "name=$CONTAINER")"
if [ ! -z "$CONTAINER" ]; then
    SUFFIX="$(tr -dc a-z0-9 </dev/urandom | head -c 8)"
    $PODMAN container rename "$CONTAINER" "$CONTAINER-$SUFFIX"
fi

TIMESTAMP="$(date "+%Y%m%d%H%M%S")"

$PODMAN build . -t "$IMAGE:latest" -t "$IMAGE:$TIMESTAMP"
toolbox create -i "$IMAGE" "$CONTAINER"

