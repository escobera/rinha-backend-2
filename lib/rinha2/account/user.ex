defmodule Rinha2.Account.User do
  alias Rinha2.Account.Transaction

  use Ecto.Schema

  schema "users" do
    field :limit, :integer
    field :balance, :integer
    has_many :transactions, Transaction
  end
end
