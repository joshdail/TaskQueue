# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :task_queue,
  ecto_repos: []

# Configures the endpoint
config :task_queue, TaskQueueWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  secret_key_base: "LSKJEIVNSODFSDOIUF",
  server: true,
  live_view: [signing_salt: "BNMNXCVZXGSDKJFL"]

config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :phoenix_live_view, :enable_expensive_runtime_checks, true

# Import environment-specific config if needed
# import_config "#{config.env()}.exs"
