defmodule TestApp.Router do
  use Phoenix.Router

  forward "/frontends", PhoenixFrontendDeploys.Web
end

defmodule TestApp do
  use Phoenix.Endpoint, otp_app: :test_app
  plug TestApp.Router
end
