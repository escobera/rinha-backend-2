defmodule Rinha2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # topologies = [
    #   example: [
    #     strategy: Cluster.Strategy.Epmd,
    #     config: [hosts: [:"a@127.0.0.1", :"b@127.0.0.1"]]
    #   ]
    # ]

    ReleaseTasks.migrate()

    children = [
      # Starts a worker by calling: Rinha2.Worker.start_link(arg)
      Rinha2.Repo,
      {Bandit, plug: Web.Router, port: System.get_env("PORT") || 4000},
      # {Rinha2.Core.Cache, []},
      # {Cluster.Supervisor, [topologies, [name: Rinha2.ClusterSupervisor]]},
      # {Task, &Rinha2.Core.Cache.load_clientes/0}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rinha2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
