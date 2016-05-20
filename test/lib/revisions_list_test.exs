defmodule PhoenixFrontendDeploys.RevisionsListTest do
  use ExUnit.Case
  doctest PhoenixFrontendDeploys.RevisionsList

  alias PhoenixFrontendDeploys.RevisionsList

  test "Gets revision list from directory" do
    revisions = RevisionsList.all

    assert revisions == ["abc123", "xyz123"]
  end

end
