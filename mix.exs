defmodule JsonLogic.Mixfile do
  use Mix.Project

  def project do
    [
      app: :json_logic,
      package: %{
        description: "Elixir implementation of JsonLogic",
        links: %{github: "https://github.com/liuming/json_logic_elixir"},
        maintainers: ["Ming Liu"],
        licenses: ["MIT"]
      },
      docs: [main: "JsonLogic", extras: ["README.md"]],
      version: "1.2.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, ">= 0.0.0"},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end
end
