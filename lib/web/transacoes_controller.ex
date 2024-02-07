defmodule Web.TransacoesController do
  alias Rinha2.Core.Transacao
  import Plug.Conn

  def call(conn) do
    with transacao <- Transacao.new(conn.params),
         {:ok, conta} <- Account.add_transaction(transacao) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, "{
        \"limite\": #{conta.limite},
        \"saldo\": \"#{conta.saldo}\"
      }")
    else
      {:error, :cliente_invalido} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(422, "cliente inválido")
    end
  end
end
