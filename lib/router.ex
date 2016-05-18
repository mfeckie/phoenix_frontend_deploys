defmodule PhoenixFrontendDeploys.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    PhoenixFrontendDeploys.FrontendController.index(conn, [])
  end
end
