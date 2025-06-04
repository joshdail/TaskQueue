defmodule TaskQueueWeb.EmailController do
  use TaskQueueWeb, :controller
  alias TaskQueue.Workers.EmailWorker

  def send(conn, %{"to" => to, "subject" => subject, "body" => body}) do
    EmailWorker.new(%{"to" => to, "subject" => subject, "body" => body})
    |> Oban.insert()

    json(conn, %{status: "queued"})
  end

  def send(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Missing or invalid email parameters"})
  end
end
