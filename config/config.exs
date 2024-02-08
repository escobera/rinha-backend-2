import Config

config :rinha2, ecto_repos: [Rinha2.Repo]

import_config "#{config_env()}.exs"
