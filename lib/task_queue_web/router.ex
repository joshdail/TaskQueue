defmodule TaskQueueWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    live_dashboard "/dashboard", metrics: TaskQueueWeb.Telemetry
  end

  scope "/api", TaskQueueWeb do
    pipe_through :api
    post "/enqueue", ApiController, :enqueue
    post "/send_email", EmailController, :send
  end
end
