defmodule Rinha2.Account do
  alias Rinha2.Account.User
  alias Rinha2.Account.Transaction
  alias Rinha2.Repo

  import Ecto.Query, warn: false
  import Ecto.Changeset

  def show(id) do
    user = Repo.get(User, id)

    query =
      from t in Transaction,
        where: t.user_id == ^id,
        order_by: [desc: t.created_at],
        limit: 10

    transactions =
      query
      |> Repo.all()

    {user, transactions}
  end

  def create_transaction(transaction) do
    transaction
    |> cast(%{}, [:value, :description, :user_id])
    |> check_constraint(:value, name: :limit_check)
    |> Repo.insert()
  end

end
