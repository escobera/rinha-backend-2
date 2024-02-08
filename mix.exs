defmodule Rinha2.MixProject do
  use Mix.Project

  def project do
    [
      app: :rinha2,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Rinha2.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.2.0"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.17.4"},
      {:jason, "~> 1.4"},
      # {:libcluster, "~> 3.3"},
      # {:nebulex_adapters_horde, "~> 1.0.1"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
