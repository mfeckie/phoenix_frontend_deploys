defmodule PhoenixFrontendDeploys.RouterTest do
  use ExUnit.Case, async: true

  use Plug.Test

  test "Routing" do
    index = conn(:get, "/frontends")
    |> TestApp.Router.call([])

    status = index.status

    assert status == 200
  end
end
