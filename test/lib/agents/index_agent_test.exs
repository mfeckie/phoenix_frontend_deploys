defmodule PhoenixFrontendDeploys.IndexAgentTest do
  use ExUnit.Case

  alias PhoenixFrontendDeploys.IndexAgent

  defp fixture_file do
    Path.join([Application.get_env(:phoenix_frontend_deploys, :asset_directory), "index.html"])
    |> File.read!
  end

  test "Stores the index.html file in agent" do
    IndexAgent.start_link
    result = IndexAgent.get

    assert result == fixture_file
  end

  test "Updates the file" do
    IndexAgent.start_link
    IndexAgent.update_index("index2.html")

    result = IndexAgent.get

    assert result == "Index2\n"
  end


end
