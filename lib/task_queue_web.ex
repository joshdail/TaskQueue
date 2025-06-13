defmodule TaskQueueWeb do

  def controller do
    quote do
      use Phoenix.Controller, namespace: TaskQueueWeb
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {TaskQueueWeb.Layouts, :app}

        unquote(view_helpers())
    end
  end

  defp view_helpers do
    quote do
      import Phoenix.HTML
      import Phoenix.LiveView.Helpers
      import Phoenix.LiveView.Router
      alias TaskQueueWeb.Router.Helpers, as: Routes
    end
  end
end
