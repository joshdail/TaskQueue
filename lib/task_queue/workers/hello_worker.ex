defmodule TaskQueue.Workers.HelloWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"name" => name}}) do
    IO.puts("[HelloWorker] Hello")
    :ok
  end
end
