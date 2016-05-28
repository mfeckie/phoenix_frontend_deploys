defmodule PhoenixFrontendDeploys.LightningController do
  @moduledoc """
  Convenience helper for service static assets

  Requires the following settings in your config

  ```
  assets: [
    asset_url: "{the desired url}",
    asset_directory: "{full path of your asset directory}"
  ]
  ```

  ## Usage

  ```
  defmodule MyLightningController do
    use PhoenixFrontendDeploys.LightningController
  end
  ```

  """
  defmacro __using__([]) do
    asset_config = Application.get_env(:phoenix_frontend_deploys, :assets)
    quote do
      use Plug.Builder
      plug Plug.Static, at: unquote(asset_config[:asset_url]), from: Path.expand(unquote(asset_config[:asset_directory])), gzip: true
      plug :not_found

      def not_found(conn, _) do
        send_resp(conn, 404, "Not found")
      end

    end
  end
end
