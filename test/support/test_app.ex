defmodule TestApp.Router do
  use Phoenix.Router

  get "/frontends", PhoenixFrontendDeploys.FrontendController, :index


  get "/revisions", TestController, :index
  post "revisions/activate", TestController, :activate
end

defmodule TestApp do
  use Phoenix.Endpoint, otp_app: :test_app
  plug TestApp.Router
end

defmodule TestController do
  use PhoenixFrontendDeploys.RevisionsController
end
