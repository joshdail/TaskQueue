defmodule TaskQueueWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser
    live_dashboard "/dashboard", metrics: TaskQueueWeb.Telemetry
  end
end
