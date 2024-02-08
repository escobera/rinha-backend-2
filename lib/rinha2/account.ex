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
    Repo.transaction(fn ->
      query = from u in User, where: u.id == ^transaction.user_id, lock: "FOR UPDATE"
      user = Repo.one!(query)

      new_user_balance = user.balance + transaction.value

      case new_user_balance + user.limit < 0 do
        true ->
          {:error, "Valor excede o limite"}

        false ->
          from(u in User, where: u.id == ^user.id, update: [set: [balance: ^new_user_balance]])
          |> Repo.update_all([])

          transaction
          |> cast(%{}, [:value, :description, :user_id])
          |> Repo.insert()
      end
    end)
  end
end
