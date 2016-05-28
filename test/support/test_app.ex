defmodule TestApp.Router do
  use Phoenix.Router

  require PhoenixFrontendDeploys.Router
  alias PhoenixFrontendDeploys.Router

  Router.frontend

  Router.revisions_api(TestApp.RevisionsController)

end


defmodule TestApp.Endpoint do
  use Phoenix.Endpoint, otp_app: :test_app
  plug TestApp.Router
end

defmodule TestApp.FrontendController do
  use PhoenixFrontendDeploys.FrontendController
end

defmodule TestApp.RevisionsController do
  use PhoenixFrontendDeploys.RevisionsController
end


defmodule TestApp do
  use Application

  def start(_blah, _blah2) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(TestApp.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: TestApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
