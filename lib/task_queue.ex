defmodule TaskQueue do
  @moduledoc """
  Task queue logic
  """

  @type task :: map()
  @type queue :: list(task)

  @spec new() :: queue
  def new, do: []

  @spec enqueue(queue, task) :: queue
  def enqueue(queue, task), do: queue ++ [task]

  @spec dequeue(queue) :: {:ok, task, queue} | {:empty, queue}
  def dequeue([]), do: {:empty, []}
  def dequeue([task | rest]), do: {:ok, task, rest}
end
