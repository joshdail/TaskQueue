defmodule TaskQueue.Workers.EmailWorker do
  use Oban.Worker, queue: :emails

  require Logger
  import Swoosh.Email
  alias TaskQueue.Mailer

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"to" => to, "subject" => subject, "body" => body}}) do
    email =
      new()
      |> to(to)
      |> from({"TaskQueue", "noreply@taskqueue.local"})
      |> subject(subject)
      |> text_body(body)

    Logger.info("Sending email to #{to}")

    case Swoosh.deliver(email, Mailer) do
      {:ok, _response} ->
        Logger.info("Email sent successfully")
        :ok

      {:error, reason} ->
        Logger.error("Failed to send email: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
