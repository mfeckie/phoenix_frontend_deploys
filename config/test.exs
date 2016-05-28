use Mix.Config

config :phoenix_frontend_deploys,
  asset_directory: System.cwd <> "/test/frontend_assets",
  live_filename: "live",
  frontend: [frontend_url: "/frontends",
  frontend_controller: TestApp.FrontendController,
             frontend_function: :index]

# This is so we can test the controllers
config :phoenix,
  format_encoders: [json: Poison]
