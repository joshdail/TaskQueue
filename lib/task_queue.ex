defmodule TaskQueue do
  @moduledoc false

  def new, do: []

  def enqueue(queue, task), do: queue ++ [task]

  def dequeue([]), do: {:empty, []}
  def dequeue([task | rest]), do: {:ok, task, rest}
end
