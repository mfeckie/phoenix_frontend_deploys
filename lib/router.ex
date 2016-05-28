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

  ## Usage

  ```
  defmodule MyAwesomeRouter do
    require PhoenixFrontendDeploys.Router
    alias PhoenixFrontendDeploys.Router

    scope "/frontend" do
      Router.frontend
    end

  ```
  """
  defmacro frontend do
    opts = Application.get_env(:phoenix_frontend_deploys, :frontend)
    quote do
      get unquote(opts[:frontend_url]), unquote(opts[:frontend_controller]), unquote(opts[:frontend_function])
    end
  end

  @doc """
  Defines the API routes expected by the admin interface, requires a controller to route to

  ## Example
      defmodule MyAwesomeRouter do
        require PhoenixFrontendDeploys.Router
        alias PhoenixFrontendDeploys.Router

        scope "/frontend/api" do
          Router.revisions_api(MyAdminController)
        end
      end
  """
  defmacro revisions_api(controller) do
    quote do
      get "/revisions", unquote(controller), :index
      post "/revisions/activate", unquote(controller), :activate
    end
  end

  @doc """
  Defines a route for serving your lightning assets

  ## Example

  ```
  defmodule MyAwesomeRouter do
    require PhoenixFrontendDeploys.Router
    alias PhoenixFrontendDeploys.Router

    scope "/lightning" do
      Router.lightning(MyLightningController)
    end
  end
  ```
  """
  defmacro lightning(controller) do
    quote do
      get "/*catch_all", unquote(controller), :assets
    end
  end

end
