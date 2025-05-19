defmodule TaskQueue.Worker do
  use GenServer

  # milliseconds between dequeue attempts
  @interval 1000

  # retry attempts allowed
  @retry 3

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
        try do
          run_task(task)
        rescue
          error ->
            IO.puts("Error running task: #{Exception.message(error)}")

            if task[:retry] < @retry do
              updated = Map.update!(task, :retry, &(&1 + 1))
              IO.puts("Retrying (attempt #{updated[:retry]})")
              TaskQueue.Server.enqueue(updated)
            else
              IO.puts("Task failed after #{@retry} attempts: #{inspect(task)}")
            end
        end
      {:empty, _} ->
        :ok
    end
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, @interval)
  end

  defp run_task(%{payload: "fail"} = task) do
    raise "Simulated Failure"
  end

  defp run_task(task) do
    ## Simulate doing work, or call task function
    IO.puts("Running: #{inspect(task)}")
  end
end
