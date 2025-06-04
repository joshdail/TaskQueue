# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :task_queue,
  ecto_repos: [TaskQueue.Repo]

config :task_queue, TaskQueue.Repo,
  database: "task_queue_dev",
  username: "josh",
  password: "",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :task_queue, Oban,
  repo: TaskQueue.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# Configures the endpoint
config :task_queue, TaskQueueWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  server: true,
  render_errors: [
    formats: [html: TaskQueueWeb.ErrorHTML, json: TaskQueueWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TaskQueue.PubSub

config :task_queue, TaskQueue.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.mailtrap.io",
  username: System.fetch_env!("USERNAME"),
  password: System.fetch_env!("PASSWORD"),
  port: 587,
  tls: :always,
  ssl: false,
  auth: :always,
  retries: 2,
  no_mx_lookups: false

config :swoosh, :api_client, false

config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :phoenix_live_view, :enable_expensive_runtime_checks, true

# Import environment-specific config if needed
# import_config "#{config.env()}.exs"
