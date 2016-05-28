defmodule PhoenixFrontendDeploys.RevisionsList do
  @moduledoc """
  The RevisionsList module is reponsible for parsing
  files in the asset directory to extract their revision tags
  """
  alias PhoenixFrontendDeploys.Revision

  @asset_directory Application.get_env(:phoenix_frontend_deploys, :asset_directory)
  @revision_regex ~r/(?::)(?P<revision>\w*)(?:\.)/


  @doc """
  Returns a list of the revisions available in the asset directory
  """
  def all do
    Path.wildcard(@asset_directory <> "/*.html")
    |> Enum.map(&to_revision_struct/1)
  end

  defp to_revision_struct(filename) do
    revision = File.stat!(filename)
    |> time_and_size
    |> Map.put(:filename, filename)
    |> Map.put(:revision, to_revision(filename))

    Map.put(revision, :active, active?(revision))
  end

  defp active?(%{revision: revision}) do
    current = PhoenixFrontendDeploys.IndexAgent.current
    current == revision
  end

  defp time_and_size(%{mtime: mtime, size: size}), do: %Revision{mtime: mtime, size: size}

  @doc false
  def to_revision(filename) do
    filename
    |> capture_revision
    |> extract_revision
  end

  defp capture_revision(filename), do: Regex.named_captures(@revision_regex, filename)

  defp extract_revision(%{"revision" => revision}), do: revision

end
