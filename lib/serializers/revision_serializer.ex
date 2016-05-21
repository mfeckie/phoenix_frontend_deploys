defmodule PhoenixFrontendDeploys.RevisionSerializer do
  use JaSerializer

  attributes [:revision, :mtime, :size]
end
