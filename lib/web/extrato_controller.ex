defmodule Web.ExtratoController do
  alias Rinha2.Account
  alias Rinha2.Account.Transaction

  import Plug.Conn

  def call(conn) do
    with {user, transactions} <- Account.show(conn.params["user_id"]) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, """
      {
        "saldo": {
          "total": #{user.balance},
          "data_extrato": "#{NaiveDateTime.utc_now()}",
          "limite": #{user.limit}
        },
        "ultimas_transacoes": [#{print_transactions(transactions)}]
      }
      """)
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "cliente inválido")
    end
  end


  defp print_transactions(transactions) do
    Enum.map(transactions, &print_transaction/1) |> Enum.join(",\n")
  end

  defp print_transaction(transaction) do
    """
    {
      "valor": #{abs(transaction.value)},
      "tipo": "#{Transaction.transaction_type(transaction.value)}",
      "descricao": "#{transaction.description}",
      "realizada_em": "#{transaction.created_at}"
    }
    """
  end
end
