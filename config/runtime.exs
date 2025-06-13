import Config

if config_env() in [:prod, :dev] do
  config :task_queue, TaskQueueWeb.Endpoint,
    secret_key_base: System.get_env("SECRET_KEY_BASE") || "dummy_secret_key_base",
    live_view: [signing_salt: System.get_env("SIGNING_SALT") || "dummy_salt"]
end

if config_env() == :dev do
  config :task_queue, TaskQueue.Mailer,
    adapter: Swoosh.Adapters.Local
end
