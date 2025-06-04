defmodule TaskQueue.Application do
  @moduledoc false

  use Application

  defp oban_config do
    [
      repo: TaskQueue.Repo,
      plugins: [Oban.Plugins.Pruner],
      queues: [
        default: [limit: 10],
        emails: [limit: 10]
      ]
    ]
  end

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: TaskQueue.Registry},
      TaskQueue.Repo,
      TaskQueue.Server,
      TaskQueue.DeadLetter,
      TaskQueueWeb.Endpoint,
      {Oban, oban_config()},
      Supervisor.child_spec({TaskQueue.Worker, "worker-1"}, id: :worker_1),
      Supervisor.child_spec({TaskQueue.Worker, "worker-2"}, id: :worker_2),
      Supervisor.child_spec({TaskQueue.Worker, "worker-3"}, id: :worker_3)
    ]

    opts = [strategy: :one_for_one, name: TaskQueue.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
