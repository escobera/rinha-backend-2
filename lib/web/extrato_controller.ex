defmodule Web.ExtratoController do
  import Plug.Conn

  def call(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "extrato")
  end
end
