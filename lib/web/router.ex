defmodule Web.Router do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Jason
  )

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/clientes/:user_id/transacoes" when user_id in ~w(1 2 3 4 5) do
    Web.TransacoesController.call(conn)
  end

  get "/clientes/:user_id/extrato" when user_id in ~w(1 2 3 4 5) do
    Web.ExtratoController.call(conn)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
