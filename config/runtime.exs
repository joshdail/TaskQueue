import Config

if config_env() == :prod or config_env() == :dev do
  config :task_queue, TaskQueueWeb.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  live_view: [signing_salt: System.fetch_env!("SIGNING_SALT")]
end
