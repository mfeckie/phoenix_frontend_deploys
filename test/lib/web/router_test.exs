defmodule PhoenixFrontendDeploys.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test
  @endpoint TestApp.Endpoint

  test "Get frontend" do
    index = conn(:get, "/frontends")
    |> TestApp.Router.call([])

    status = index.status

    assert status == 200
  end

  test "Get revisions" do
    revisions = conn(:get, "frontend_api/revisions")
    |> TestApp.Router.call([])

    status = revisions.status

    assert status == 200
  end

  test "Post revision" do
    # TODO - Test through the Router.  I'm not thrilled with this method, but trying to get Phoenix parameter parsing working outside phoenix has been troublesome.
    conn = conn(:post, "frontend_api/revisions/activate", %{"revision" => "abc123"})
    revision = TestController.activate(conn, %{"revision" => "abc123"})

    status = revision.resp_body
    assert status ==  "{\"revision\":\"abc123\"}"
  end
end
