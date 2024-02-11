defmodule Rinha2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Rinha2.Worker.start_link(arg)
      Rinha2.Repo,
      {Bandit, plug: Web.Router, port: System.get_env("PORT") || 4000},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rinha2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
