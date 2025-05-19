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

  ## Below is the boilerplate code. I'm leaving it here commented out for now
  # @impl true
  # def start(_type, _args) do
  #   children = [
  #     TaskQueueWeb.Telemetry,
  #     TaskQueue.Repo,
  #     {DNSCluster, query: Application.get_env(:task_queue, :dns_cluster_query) || :ignore},
  #     {Phoenix.PubSub, name: TaskQueue.PubSub},
  #     # Start the Finch HTTP client for sending emails
  #     {Finch, name: TaskQueue.Finch},
  #     # Start a worker by calling: TaskQueue.Worker.start_link(arg)
  #     # {TaskQueue.Worker, arg},
  #     # Start to serve requests, typically the last entry
  #     TaskQueueWeb.Endpoint
  #   ]

  #   # See https://hexdocs.pm/elixir/Supervisor.html
  #   # for other strategies and supported options
  #   opts = [strategy: :one_for_one, name: TaskQueue.Supervisor]
  #   Supervisor.start_link(children, opts)
  # end

  # # Tell Phoenix to update the endpoint configuration
  # # whenever the application is updated.
  # @impl true
  # def config_change(changed, _new, removed) do
  #   TaskQueueWeb.Endpoint.config_change(changed, removed)
  #   :ok
  # end
end
