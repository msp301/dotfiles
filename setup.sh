#!/bin/sh

IMAGE=devbox
CONTAINER=dev

CONTAINER_ID="$(podman ps -q --filter "name=$CONTAINER")"
if [ ! -z "$CONTAINER" ]; then
    SUFFIX="$(tr -dc a-z0-9 </dev/urandom | head -c 8)"
    podman container rename "$CONTAINER" "$CONTAINER-$SUFFIX"
fi

TIMESTAMP="$(date "+%Y%m%d%H%M%S")"

podman build . -t "$IMAGE:latest" -t "$IMAGE:$TIMESTAMP"
toolbox create -i "$IMAGE" "$CONTAINER"

