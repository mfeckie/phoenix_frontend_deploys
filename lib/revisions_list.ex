defmodule PhoenixFrontendDeploys.RevisionsList do
  @moduledoc """
  The RevisionsList module is reponsible for parsing
  files in the asset directory to extract their revision tags
  """

  @asset_directory Application.get_env(:phoenix_frontend_deploys, :asset_directory)
  @revision_regex ~r/(?::)(?P<revision>\w*)(?:\.)/


  @doc """
  Returns a list of the revisions available in the asset directory

  ## Examples

      iex> PhoenixFrontendDeploys.RevisionsList.all
      ["abc123", "xyz123"]
  """
  def all do
    Path.wildcard(@asset_directory <> "/*.html")
    |> Enum.map(&Path.basename/1)
    |> get_revisions
  end

  defp get_revisions(filenames) do
    filenames
    |> Enum.map(&capture_revision/1)
    |> Enum.map(&extract_revision/1)
  end

  defp capture_revision(filename), do: Regex.named_captures(@revision_regex, filename)

  defp extract_revision(%{"revision" => revision}), do: revision

end
