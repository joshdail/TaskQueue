defmodule TaskQueue.DeadLetter do
  use GenServer

  @moduledoc """
  Stores tasks that exceeded their max retry attempts
  """

  # Public API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def report(task) do
    GenServer.cast(__MODULE__, {:report, task})
  end

  def list do
    GenServer.call(__MODULE__, :list)
  end

  # GenServer callbacks

  def init(_args), do: {:ok, []}

  def handle_cast({:report, task}, state) do
    IO.puts("Task moved to dead letter queue: #{inspect(task)}")
    {:noreply, [task | state]}
  end

  def handle_call(:list, _from, state) do
    {:reply, Enum.reverse(state), state}
  end
end
