#!/bin/sh
set -e

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- /usr/local/bin/nats-server "$@"
fi

# check for the expected command
if [ "$1" = 'nats-server' ]; then
    exec "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"

