defmodule Sptfy.Object.Helpers do
  @moduledoc false

  def atomize_keys(map, opts \\ %{})

  def atomize_keys(map, [{:underscore, true} | _]) do
    do_atomize_keys(map, &underscore_atom/1)
  end

  def atomize_keys(map, _opts) do
    do_atomize_keys(map, &String.to_atom/1)
  end

  def do_atomize_keys(map, fun) do
    map
    |> Enum.map(fn
      {k, v} when is_binary(k) -> {fun.(k), v}
      {k, v} when is_atom(k) -> {k, v}
    end)
    |> Enum.into(%{})
  end

  defp underscore_atom(str) do
    ~r/[A-Z]/
    |> Regex.replace(str, fn c -> "_" <> String.downcase(c) end)
    |> String.to_atom()
  end

  def parse_timestamp(str) do
    {:ok, datetime, _} = DateTime.from_iso8601(str)
    datetime
  end
end
