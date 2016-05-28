defmodule PhoenixFrontendDeploys.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_frontend_deploys,
     version: "0.0.1-alpha.0",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger, :plug],
     mod: {PhoenixFrontendDeploys, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:ja_serializer, "~> 0.9.0"},
      {:phoenix, "~> 1.1", optional: true}
    ]
  end

  defp description do
    """
    An extension for Phoenix to faciliate live frontend deploys
    """
  end

  defp package do
    [
      name: :phoenix_frontend_deploys,
      maintainers: ["Martin Feckie"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/mfeckie/phoenix_frontend_deploys"
      }
    ]
  end
end
