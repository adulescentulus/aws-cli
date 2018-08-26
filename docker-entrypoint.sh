#!/bin/bash
set -e

if [ "$1" = '/build.sh' ]; then
    chmod /build/build.sh
fi

exec "$@"
