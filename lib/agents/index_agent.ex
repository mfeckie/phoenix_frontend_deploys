defmodule PhoenixFrontendDeploys.IndexAgent do
  @moduledoc """
  Index agent is responsible for holding the currently activated index file and for updating it.

  Requires a `live` file that holds the name of the activated revision.  This
  is to allow for persitence in the event of a server restart.
  """
  alias PhoenixFrontendDeploys.IndexAgent

  @asset_directory Application.get_env(:phoenix_frontend_deploys, :asset_directory)
  @live_filename Application.get_env(:phoenix_frontend_deploys, :live_filename)
  @live_file_path Path.join([@asset_directory, @live_filename])


  def start_link do
    Agent.start_link(fn ->
      IndexAgent.initialize_index
    end, name: __MODULE__)
  end

  def initialize_index do
    get_live_index_filename
    |> cache_index
  end

  @doc"""
  Given a revision id sets this as the current index
  """
  def activate(revision) do
    File.write!(@live_file_path, "index:" <> revision <> ".html")
    update_index
  end

  @doc """
  Returns the currently active revision
  """
  def current do
    get_live_index_filename
    |> PhoenixFrontendDeploys.RevisionsList.to_revision
  end

  @doc """
  Returns the currently active index file.
  """
  def get do
    Agent.get(__MODULE__, fn index -> index end)
  end

  @doc """
  Updates the in memory index file to match the one named in the `live` file.
  """
  def update_index do
    Agent.update(__MODULE__, fn _ ->
      get_live_index_filename
      |> cache_index
    end)
  end

  defp get_live_index_filename do
    live_filename = Path.join([@asset_directory, @live_filename])
    File.read!(live_filename)
  end

  defp cache_index(filename) do
    Path.join([@asset_directory, String.strip(filename)])
  end

end
