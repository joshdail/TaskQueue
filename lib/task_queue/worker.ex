defmodule TaskQueue.Worker do
  use GenServer

  ## ms between dequeue attempts
  @interval 1000

  def start_link(id) do
    GenServer.start_link(__MODULE__, %{}, name: via_name(id))
  end

  defp via_name(id), do: {:via, Registry, {TaskQueue.Registry, id}}

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    case TaskQueue.Server.dequeue() do
      {:ok, task} ->
        IO.inspect(task, label: "Processing task")
        run_task(task)

      {:empty, _} ->
        :ok
    end
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, @interval)
  end

  defp run_task(task) do
    ## Simulate doing work, or call task function
    IO.puts("Running: #{inspect(task)}")
  end
end
