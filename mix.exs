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
      {:finch, "~> 0.5"}
    ]
  end
end
