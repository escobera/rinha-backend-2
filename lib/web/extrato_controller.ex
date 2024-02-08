defmodule Web.ExtratoController do
  alias Rinha2.Account
  alias Rinha2.Account.Transaction

  import Plug.Conn

  def call(conn) do
    with {user, transactions} <- Account.show(conn.params["user_id"]) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(build_response(user, transactions)))
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "cliente inválido")
    end
  end

  defp build_response(user, transactions) do
    %{
      saldo: %{
        total: user.balance,
        data_extrato: NaiveDateTime.utc_now(),
        limite: user.limit
      },
      ultimas_transacoes: build_transactions(transactions)
    }
  end

  defp build_transactions(transactions) do
    Enum.map(transactions, &build_transaction/1)
  end

  defp build_transaction(transaction) do
    %{
      valor: abs(transaction.value),
      tipo: Transaction.transaction_type(transaction.value),
      descricao: transaction.description,
      realizada_em: transaction.created_at
    }
  end
end
