defmodule PhoenixFrontendDeploys.RevisionsControllerTest do
  use ExUnit.Case
  use Plug.Test

  alias PhoenixFrontendDeploys.IndexAgent

  setup do
    set_live_file_content("index:abc123.html")
    IndexAgent.update_index

    on_exit fn ->
      set_live_file_content("index:abc123.html")
    end
    :ok
  end

  defp set_live_file_content(index_name) do
    File.write!(Path.join([Application.get_env(:phoenix_frontend_deploys, :asset_directory), "live"]), index_name)
  end


  test "Returns serialized list of revisions" do
    conn = conn(:get, "/")

    response = TestController.index(conn, [])
    |> deserialize
    |> Map.get(:attributes)

    assert response == %{active: true, id: "abc123", mtime: "2016-5-22 14:13:25", size: 143}
  end

  defp deserialize(%{resp_body: resp_body}) do
    Poison.decode!(resp_body, keys: :atoms)
    |> Map.get(:data)
    |> hd
  end

  test "Updates the index" do
    post_conn = conn(:post, "/")

    # We're not testing the routing of the post_conn, only how we deal with the params
    TestController.activate(post_conn, %{"revision" => "xyz123"})

    index_now = IndexAgent.get

    assert Regex.match?(~r/xyz123.html/, index_now)

  end

end

