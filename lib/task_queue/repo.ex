defmodule TaskQueue.Repo do
  use Ecto.Repo,
    otp_app: :task_queue,
    adapter: Ecto.Adapters.Postgres
end
