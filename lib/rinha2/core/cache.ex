defmodule Rinha2.Core.Cache do
  alias Rinha2.Core.Cliente
  alias Rinha2.Repo

  use Nebulex.Cache,
    otp_app: :rinha2,
    adapter: Nebulex.Adapters.Horde,
    horde: [
      members: :auto,
      process_redistribution: :passive
      # any other Horde options ...
    ]

  def load_clientes do
    Repo.all(Cliente) |> dbg()
  end
end
