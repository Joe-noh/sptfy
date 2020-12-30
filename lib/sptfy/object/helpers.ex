defmodule Sptfy.Object.Helpers do
  @moduledoc false

  def atomize_keys(map) do
    map
    |> Enum.map(fn
      {k, v} when is_binary(k) -> {String.to_atom(k), v}
      {k, v} when is_atom(k) -> {k, v}
    end)
    |> Enum.into(%{})
  end
end
