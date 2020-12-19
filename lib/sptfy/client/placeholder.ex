defmodule Sptfy.Client.Placeholder do
  @moduledoc false

  @doc false
  @spec extract(str :: String.t()) :: [atom()]
  def extract(str) do
    Regex.scan(~r/:(\w+)/, str)
    |> Enum.map(fn [_whole, name] -> name end)
    |> Enum.map(&String.to_atom/1)
  end

  @doc false
  @spec fill(str :: String.t(), params :: map()) :: String.t()
  def fill(str, params) do
    Enum.reduce(params, str, fn {k, v}, acc ->
      String.replace(acc, ":#{k}", to_string(v), global: false)
    end)
  end
end
