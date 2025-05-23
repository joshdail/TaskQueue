defmodule TaskQueue.Workers.HttpWorker do
  use Oban.Worker, queue: :default

  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"url" => url}}) do
    Logger.info("Making HTTP GET request to #{url}")

    case Req.get(url) do
      {:ok, %Req.Response{status: status, body: body}} ->
        Logger.info("Got response with status#{status}")
        Logger.debug("Response body: #{inspect(body)}")
        :ok
      {:error, reason} ->
        Logger.error("Failed request to #{url}: #{inspect(reason)}")
        {:error, reason}
    end
  end

end
