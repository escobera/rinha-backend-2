defmodule Web.Router do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Jason
  )

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/clientes/:cliente_id/transacoes" when cliente_id in ~w(1 2 3 4 5) do
    Web.TransacoesController.call(conn)
  end

  get "/clientes/:cliente_id/extrato" when cliente_id in ~w(1 2 3 4 5) do
    Web.ExtratoController.call(conn)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
