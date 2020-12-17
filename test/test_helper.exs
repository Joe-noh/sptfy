ExUnit.start()

defmodule TestHelpers do
  def stringify_keys(map) when is_struct(map) do
    map |> Map.from_struct() |> stringify_keys()
  end

  def stringify_keys(map) do
    map |> Enum.map(fn {k, v} -> {Atom.to_string(k), v} end) |> Enum.into(%{})
  end
end
