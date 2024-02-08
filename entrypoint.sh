#!/bin/sh

bin="/app/bin/rinha2"

eval "$bin eval \"ReleaseTasks.migrate\""
# start the elixir application
exec "$bin" "start"