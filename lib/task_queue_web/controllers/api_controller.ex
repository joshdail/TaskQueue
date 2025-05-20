defmodule TaskQueueWeb.ApiController do
  use TaskQueueWeb, :controller

  def enqueue(conn, %{"task" => task_params}) do
    TaskQueue.Server.enqueue(task_params)

    conn
    |> put_status(:accepted)
    |> json(%{status: "queued"})
  end

  def enqueue(conn, params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Missing task payload"})
  end
end
