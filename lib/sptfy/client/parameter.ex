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
      {key, value}, {keys, fixed} ->
        fixed = Map.put(fixed, key, value)
        {keys, fixed}

      key, {keys, fixed} ->
        keys = [key | keys]
        {keys, fixed}
    end)
  end
end
