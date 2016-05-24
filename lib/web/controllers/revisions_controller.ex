defmodule PhoenixFrontendDeploys.RevisionsController do
  import Plug.Conn
  import Phoenix.Controller, only: [text: 2, scrub_params: 2, json: 2]

  alias PhoenixFrontendDeploys.IndexAgent

  defmacro __using__(_) do
    quote do
      import PhoenixFrontendDeploys.RevisionsController
      use Phoenix.Controller

      def index(conn, params) do
        render_index(conn, params)
      end

      def activate(conn, params) do
        activate_index(conn, params)
      end
    end
  end


  def render_index(conn, _params) do
    current_revision = IndexAgent.current
    revisions = PhoenixFrontendDeploys.RevisionsList.all
    |> PhoenixFrontendDeploys.RevisionSerializer.format
    |> Poison.encode!

    conn
    |> put_resp_header("content-type", "application/json")
    |> text(revisions)
  end

  def activate_index(conn, params) do
    revision = params["revision"]
    IndexAgent.activate(revision)

    conn
    |> json(%{revision: revision})
  end


end
