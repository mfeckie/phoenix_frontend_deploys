defmodule PhoenixFrontendDeploys.RevisionsController do
  import Plug.Conn
  import Phoenix.Controller, only: [text: 2]

  defmacro __using__(_) do
    quote do
      import PhoenixFrontendDeploys.RevisionsController

      def index(conn, params) do
        render_index(conn, params)
      end
    end
  end


  def render_index(conn, _params) do
    revisions = PhoenixFrontendDeploys.RevisionsList.all
    |> PhoenixFrontendDeploys.RevisionSerializer.format
    |> Poison.encode!

    conn
    |> put_resp_header("content-type", "application/json")
    |> text(revisions)
  end


end
