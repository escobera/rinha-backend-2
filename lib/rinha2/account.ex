defmodule Rinha2.Account do
  alias Rinha2.Account.User
  alias Rinha2.Account.Transaction
  alias Rinha2.Repo

  import Ecto.Query, warn: false
  import Ecto.Changeset

  def show(id) do
    query =
      from u in User,
        where: u.id == ^id,
        left_join: t in Transaction,
        on: t.user_id == u.id,
        preload: [transactions: t]

    query
    |> Repo.one()
  end

  def create_transaction(transaction) do
    transaction
    |> cast(%{}, [:value, :description, :user_id])
    |> check_constraint(:value, name: :limit_check)
    |> Repo.insert()
  end

end
