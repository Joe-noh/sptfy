defmodule Sptfy.MixProject do
  use Mix.Project

  def project do
    [
      name: "Sptfy",
      description: "Spotify API client library.",
      app: :sptfy,
      version: "0.1.1",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      source_url: "https://github.com/Joe-noh/sptfy"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Sptfy.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:finch, "~> 0.5"},
      {:jason, "~> 1.2"},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:mock, "~> 0.3", only: :test}
    ]
  end

  defp docs do
    [
      main: "Sptfy",
      authors: ["Joe-noh"],
      formatters: ["html"],
      groups_for_modules: [
        OAuth: Sptfy.OAuth,
        "API Modules": ~r/^Sptfy.[^.]+$/,
        Objects: ~r/^Sptfy\.Object\..+$/
      ]
    ]
  end

  defp package do
    [
      name: "sptfy",
      files: ~w[lib .formatter.exs mix.exs README* LICENSE*],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Joe-noh/sptfy"}
    ]
  end
end
