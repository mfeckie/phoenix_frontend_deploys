defmodule PhoenixFrontendDeploys.FrontendController do
  use PhoenixFrontendDeploys.Web, :controller

  def index(conn, _params) do
    conn
    |> send_resp(200, "OK")
  end
end
