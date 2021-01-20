defmodule Sptfy.Client.Parameter do
  @moduledoc false

  @doc false
  @spec prepare(params :: map(), schema :: list()) :: map()
  def prepare(params, schema) do
    {keys, fixed} = parse(schema)

    params
    |> Map.take(keys)
    |> Map.merge(fixed)
  end

  @doc false
  @spec check_required!(params :: map(), schema :: list()) :: :ok | no_return()
  def check_required!(params, schema) do
    schema
    |> fetch_required_keys()
    |> raise_if_missing(params)
  end

  defp parse(schema) do
    Enum.reduce(schema, {[], %{}}, fn
      {key, opts}, {keys, fixed_values_map} ->
        case Keyword.get(opts, :fixed) do
          nil -> {keys, fixed_values_map}
          value -> {keys, Map.put(fixed_values_map, key, value)}
        end

      key, {keys, fixed_values_map} ->
        keys = [key | keys]
        {keys, fixed_values_map}
    end)
  end

  defp fetch_required_keys(schema) do
    Enum.reduce(schema, [], fn
      {key, opts}, acc ->
        if Keyword.get(opts, :required) do
          [key | acc]
        else
          acc
        end

      _key, acc ->
        acc
    end)
  end

  defp raise_if_missing(required_keys, params) do
    Enum.each(required_keys, fn key ->
      unless Map.has_key?(params, key) do
        raise ArgumentError, "Required params #{key} is missing."
      end
    end)
  end
end
