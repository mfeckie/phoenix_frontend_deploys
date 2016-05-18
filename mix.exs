defmodule PhoenixFrontendDeploys.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_frontend_deploys,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {PhoenixFrontendDeploys, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:phoenix, "~> 1.1", optional: true}
    ]
  end
end
