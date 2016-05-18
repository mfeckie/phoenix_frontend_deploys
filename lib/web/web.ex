defmodule PhoenixFrontendDeploys.Web do

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def controller do
    quote do
      use Phoenix.Controller
    end
  end

  use Plug.Builder

  plug PhoenixFrontendDeploys.Router
end
