defmodule Web.TransacoesController do
  alias Rinha2.Account.User
  alias Rinha2.Account.Transaction
  alias Rinha2.Account
  alias Rinha2.Repo

  import Plug.Conn

  def call(conn) do
    with {:ok, transaction} <- Transaction.build(conn.params),
         {:ok, _} <- Account.create_transaction(transaction),
         user <- Repo.get(User, conn.params["user_id"]) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, "{\"limite\": #{user.limit},\"saldo\": \"#{user.balance}\"}")
    else
      {:error, :cliente_invalido} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "cliente inválido")

      # {:error, %Ecto.Changeset{errors: [value: {"is invalid", [constraint: :check, constraint_name: "limit_check"]}]} = _changeset} ->
      #   conn
      #   |> put_resp_content_type("application/json")
      #   |> send_resp(422, "pode não fi")
      {:error, %Ecto.Changeset{errors: _} = _changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "pode não fi")

      {:error, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "deu ruim")
    end
  end
end
