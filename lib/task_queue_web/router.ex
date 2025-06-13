defmodule TaskQueueWeb.Router do
  use Phoenix.Router
  # import Phoenix.LiveDashboard.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskQueueWeb do
    pipe_through :browser
    live "/dashboard", DashBoardLive, :index
  end

  scope "/api", TaskQueueWeb do
    pipe_through :api
    post "/enqueue", ApiController, :enqueue
    post "/send_email", EmailController, :send
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
