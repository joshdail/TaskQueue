defmodule TaskQueueWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :task_queue

  plug(Plug.Static, at: "/", from: :task_queue, gzip: false)

  plug(Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"
  )

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])
  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(Plug.Session,
    store: :cookie,
    key: "_task_queue_key",
    signing_salt: "secret"
  )

  plug(TaskQueueWeb.Router)
end
