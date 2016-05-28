defmodule PhoenixFrontendDeploys.FrontendController do
  defmacro __using__([]) do
    quote do
      use Phoenix.Controller

      alias PhoenixFrontendDeploys.IndexAgent

      def index(conn, _params) do
        conn
        |> send_file(200, get_index)
      end


      defp get_index, do: IndexAgent.get
    end
  end
end
