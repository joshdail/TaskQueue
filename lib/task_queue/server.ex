defmodule TaskQueue.Server do
  use GenServer

  alias TaskQueue

  ## Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, TaskQueue.new(), name: __MODULE__)
  end

  def enqueue(task) do
    task = Map.put_new(task, :retry, 0)
    GenServer.cast(__MODULE__, {:enqueue, task})
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  ## Server callbacks

  def init(queue), do: {:ok, queue}

  def handle_cast({:enqueue, task}, queue) do
    new_queue = TaskQueue.enqueue(queue, task)
    {:noreply, new_queue}
  end

  def handle_call(:dequeue, _from, queue) do
    case TaskQueue.dequeue(queue) do
      {:ok, task, new_queue} -> {:reply, {:ok, task}, new_queue}
      {:empty, _} = result -> {:reply, result, queue}
    end
  end
end
