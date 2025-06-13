defmodule TaskQueue.MixProject do
  use Mix.Project

  def project do
    [
      app: :task_queue,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {TaskQueue.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.12"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:telemetry_metrics, ">= 0.0.0"},
      {:oban, "~> 2.15"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 1.13"},
      {:gen_smtp, "~> 1.2"},
      {:finch, "~> 0.16"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:req, "~> 0.4.14"},
      {:phoenix_live_view, "~> 1.0.11"},
      {:floki, ">= 0.30.0", only: :test}
    ]
  end
end
