#!/bin/sh

touch /db/rinha2.sqlite3
chmod 644 /db/rinha2.sqlite3

bin="/app/bin/rinha2"
# start the elixir application
exec "$bin" "start"