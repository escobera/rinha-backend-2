defmodule Rinha2.Account.User do
  use Ecto.Schema

  schema "users" do
    field :saldo, :integer
    field :limite, :integer
  end
end
