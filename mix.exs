defmodule Sptfy.MixProject do
  use Mix.Project

  def project do
    [
      app: :sptfy,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Sptfy.Application, []}
    ]
  end

  defp deps do
    [
      {:finch, "~> 0.5"},
      {:jason, "~> 1.2"},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:mock, "~> 0.3", only: :test}
    ]
  end
end
