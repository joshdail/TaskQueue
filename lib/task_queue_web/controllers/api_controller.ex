defmodule TaskQueueWeb.ApiController do
  use TaskQueueWeb, :controller

  alias TaskQueue.Workers.HttpWorker
  require Logger

  def enqueue(conn, %{"task" => %{"url" => url}}) do
    Logger.info("Received enqueue request for URL: #{url}")
    job = HttpWorker.new(%{"url" => url})

    case Oban.insert(job) do
      {:ok, _job} ->
        conn
        |> put_status(:accepted)
        |> json(%{status: "queued"})

      {:error, reason} ->
        Logger.error("Failed to insert job: #{inspect(reason)}")
        conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Failed to enqueue job"})
    end
  end

  def enqueue(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Missing task payload"})
  end
end
