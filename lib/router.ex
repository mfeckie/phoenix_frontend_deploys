defmodule PhoenixFrontendDeploys.Router do
  @moduledoc """
  Convenience macros for defining routes allowing you to handle authentication as you choose.
  """

  @doc """
  Defines the route from which your frontend will be served

  Required options are
      config :phoenix_frontend_deploys,
        frontend: [frontend_url: "/frontends",
        frontend_controller: PhoenixFrontendDeploys.FrontendController,
        frontend_function: :index]
  """
  defmacro frontend do
    opts = Application.get_env(:phoenix_frontend_deploys, :frontend)
    quote do
      get unquote(opts[:frontend_url]), unquote(opts[:frontend_controller]), unquote(opts[:frontend_function])
    end
  end

  @doc """
  Defines the standard routes expected by the admin interface, requires a controller to route to

  ### Example
      defmodule MyAwesomeRouter do
        require PhoenixFrontendDeploys.Router
        alias PhoenixFrontendDeploys.Router

        Router.admin(MyAdminController)
      end
  """
  defmacro admin(controller) do
    quote do
      get "frontend_api/revisions", unquote(controller), :index
      post "frontend_api/revisions/activate", unquote(controller), :activate
    end
  end

end
