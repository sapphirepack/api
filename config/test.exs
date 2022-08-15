import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :main_app, MainApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "main_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :main_app, MainAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LNKd2du6JrNbe2CiDdHpcheIeBR5csELBP0ZYQNVrulS/whKBp/LYEZoK8tMAu3N",
  server: false

# In test we don't send emails.
config :main_app, MainApp.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
