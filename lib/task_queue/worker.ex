defmodule TaskQueue.Worker do
  use GenServer

  # milliseconds between dequeue attempts
  @interval 1000

  # default retries
  @default_retries 3

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

            retry_count = Map.get(task, :retry, 0)
            max_retries = Map.get(task, :max_retries, @default_retries)

            if retry_count < max_retries do
              updated = Map.put(task, :retry, retry_count + 1)
              IO.puts("Retrying task: #{inspect(updated)} (attempt #{updated[:retry]})")
              TaskQueue.Server.enqueue(updated)
            else
              IO.puts("Task failed after #{retry_count} attempts: #{inspect(task)}")
              TaskQueue.DeadLetter.report(task)
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

  # This function is used to test program behavior on task failure
  defp run_task(%{payload: "fail"} = task) do
    raise "Simulated Failure"
  end

  defp run_task(task) do
    ## Simulate doing work, or call task function
    IO.puts("Running: #{inspect(task)}")
  end
end
