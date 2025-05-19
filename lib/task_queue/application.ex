defmodule TaskQueue.Application do

  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: TaskQueue.Registry},
      TaskQueue.Server,
      Supervisor.child_spec({TaskQueue.Worker, "worker-1"}, id: :worker_1),
      Supervisor.child_spec({TaskQueue.Worker, "worker-2"}, id: :worker_2),
      Supervisor.child_spec({TaskQueue.Worker, "worker-3"}, id: :worker_3),

    ]
    opts = [strategy: :one_for_one, name: TaskQueue.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
