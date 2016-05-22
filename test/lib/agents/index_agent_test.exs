defmodule PhoenixFrontendDeploys.IndexAgentTest do
  use ExUnit.Case

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

  test "Stores the index.html file in agent" do
    result = IndexAgent.get

    assert Regex.match?(~r/index:abc123.html/, result)
  end

  test "Updates the file based on content of live file" do
    set_live_file_content("index:xyz123.html")
    IndexAgent.update_index

    result = IndexAgent.get

    assert Regex.match?(~r/index:xyz123.html/, result)
  end


end
