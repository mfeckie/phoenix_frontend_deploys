defmodule PhoenixFrontendDeploys.RevisionsListTest do
  use ExUnit.Case
  doctest PhoenixFrontendDeploys.RevisionsList

  alias PhoenixFrontendDeploys.RevisionsList

  test "Gets revision list from directory" do
    revisions = RevisionsList.all
    |> Enum.map(&( %{revision: &1.revision}))

    assert revisions == [%{revision: "abc123"}, %{revision: "xyz123"}]
  end

end
