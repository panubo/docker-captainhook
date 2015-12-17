#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

echo ">> Starting Captainhook..."

echo "Running $@"
if [ "$(basename $1)" == "app" ]; then
    exec "$@"
else
    exec "$@"
fi
