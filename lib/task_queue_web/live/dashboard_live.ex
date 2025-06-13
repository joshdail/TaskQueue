defmodule TaskQueueWeb.DashboardLive do
  use TaskQueueWeb, :live_view

  import Ecto.Query
  alias TaskQueue.Repo
  alias Oban.Job

  @impl true
  def mount(_params, _session, socket) do
    jobs = list_recent_jobs()
    {:ok, assign(socket, jobs: jobs)}
  end

  defp list_recent_jobs do
    Oban.Job
    |> order_by(desc: :inserted_at)
    |> limit(10)
    |> Repo.all()
  end
end
