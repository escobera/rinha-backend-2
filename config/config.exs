import Config

# config :rinha2, Rinha2.Repo,
# adapter: Ecto.Adapters.SQLite3,
# database: "db/rinha2.sqlite3"

config :rinha2, ecto_repos: [Rinha2.Repo], adapter: Ecto.Adapters.SQLite3

config :rinha2, Rinha2.Repo, database: "db/rinha2.sqlite3"
