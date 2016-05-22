defmodule PhoenixFrontendDeploys.RevisionsControllerTest do
  use ExUnit.Case
  use Plug.Test

  test "Returns serialized list of revisions" do
    conn = conn(:get, "/")

    response = TestController.index(conn, [])
    |> deserialize
    |> Map.get(:attributes)

    assert response == %{id: "abc123", mtime: "2016-5-19 14:38:41", size: 119}
  end

  defp deserialize(%{resp_body: resp_body}) do
    Poison.decode!(resp_body, keys: :atoms)
    |> Map.get(:data)
    |> hd
  end

end

defmodule TestController do
  use PhoenixFrontendDeploys.RevisionsController
end
