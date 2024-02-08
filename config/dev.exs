import Config
# Configure your database
config :rinha2, Rinha2.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5432,
  database: "rinha2_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10