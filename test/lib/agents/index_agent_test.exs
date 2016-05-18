defmodule PhoenixFrontendDeploys.IndexAgentTest do
  use ExUnit.Case

  alias PhoenixFrontendDeploys.IndexAgent

  setup do
    set_live_file_content("index.html")
    IndexAgent.update_index
    :ok
  end

  defp set_live_file_content(index_name) do
    File.write!(Path.join([Application.get_env(:phoenix_frontend_deploys, :asset_directory), "live"]), index_name)
  end

  defp fixture_file do
    Path.join([Application.get_env(:phoenix_frontend_deploys, :asset_directory), "index.html"])
    |> File.read!
  end

  test "Stores the index.html file in agent" do
    result = IndexAgent.get

    assert result == fixture_file
  end

  test "Updates the file based on content of live file" do
    set_live_file_content("index2.html")
    IndexAgent.update_index

    result = IndexAgent.get

    assert result == "Index2\n"
  end


end
