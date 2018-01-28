defmodule PhoenixPrimer.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :phoenix_primer,
      name: "Phoenix Primer",
      version: @version,
      description: "A library to help make working with GitHub's Primer CSS framework simple",

      source_url: "https://github.com/lee-dohm/phoenix-primer",

      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,

      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_html, "~> 2.10"},
      {:cmark, "~> 0.7", only: [:dev, :test]},
      {:ex_doc, "~> 0.18", only: [:dev, :test], runtime: false},
      {:version_tasks, "~> 0.10", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: "https://github.com/lee-dohm/phoenix-primer",
      markdown_processor: ExDoc.Markdown.Cmark,
      groups_for_modules: [
      ],
      extras: [
        "CONTRIBUTING.md",
        "CODE_OF_CONDUCT.md": [
          filename: "code_of_conduct",
          title: "Code of Conduct"
        ],
        "README.md": [
          filename: "readme",
          title: "README"
        ],
        "LICENSE.md": [
          filename: "license",
          title: "License"
        ]
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
