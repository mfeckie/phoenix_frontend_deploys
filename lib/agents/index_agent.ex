defmodule PhoenixFrontendDeploys.IndexAgent do
  alias PhoenixFrontendDeploys.IndexAgent

  @asset_directory Application.get_env(:phoenix_frontend_deploys, :asset_directory)
  @live_filename Application.get_env(:phoenix_frontend_deploys, :live_filename)

  def start_link do
    Agent.start_link(fn ->
      IndexAgent.initialize_index
    end, name: __MODULE__)
  end

  def initialize_index do
    get_live_index_filename
    |> cache_index
  end

  def get do
    Agent.get(__MODULE__, fn index -> index end)
  end

  def update_index(filename) do
    Agent.update(__MODULE__, fn _ ->
      cache_index(filename)
    end)
  end

  defp get_live_index_filename do
    live_filename = Path.join([@asset_directory, @live_filename])
    File.read!(live_filename)
  end

  defp cache_index(filename) do
    index_file_path = Path.join([@asset_directory, filename])
    File.read!(index_file_path)
  end

end
