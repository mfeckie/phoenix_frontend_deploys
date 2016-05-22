defmodule PhoenixFrontendDeploys.RevisionSerializer do
  use JaSerializer

  attributes [:id, :mtime, :size]

  def mtime(struct, _opts) do
    {{year, month, day}, {hour, minute, second}} = struct.mtime
    "#{year}-#{month}-#{day} #{hour}:#{minute}:#{second}"
  end

  def id(struct, _opts) do
    struct.revision
  end

end
