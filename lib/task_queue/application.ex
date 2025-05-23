defmodule TaskQueue.Application do

  @moduledoc false

  use Application

  defp oban_config do
    Application.fetch_env!(:task_queue, Oban)
  end

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: TaskQueue.Registry},
      TaskQueue.Server,
      TaskQueue.DeadLetter,
      TaskQueueWeb.Endpoint,
      TaskQueue.Repo, {Oban, oban_config()},
      Supervisor.child_spec({TaskQueue.Worker, "worker-1"}, id: :worker_1),
      Supervisor.child_spec({TaskQueue.Worker, "worker-2"}, id: :worker_2),
      Supervisor.child_spec({TaskQueue.Worker, "worker-3"}, id: :worker_3),

    ]
    opts = [strategy: :one_for_one, name: TaskQueue.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
