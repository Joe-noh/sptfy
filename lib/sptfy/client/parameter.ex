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
end
