defmodule Sptfy.Client.ResponseHandler do
  @moduledoc false

  alias Sptfy.Client.BodyMapper
  alias Sptfy.Object.Error

  @spec handle(response :: %Finch.Response{}, mapping :: BodyMapper.t()) :: :ok | {:ok, map()} | {:ok, [map()]} | {:error, Error.t()}
  def handle(%Finch.Response{body: body}, mapping) do
    case Jason.decode(body) do
      {:ok, json} -> handle_json(json, mapping)
      {:error, _} -> handle_json(%{}, mapping)
    end
  end

  defp handle_json(json, mapping) when is_map(json) do
    case Map.get(json, "error") do
      nil -> Sptfy.Client.BodyMapper.map(json, mapping)
      error -> {:error, Sptfy.Object.Error.new(error)}
    end
  end

  defp handle_json(json, mapping) when is_list(json) do
    Sptfy.Client.BodyMapper.map(json, mapping)
  end
end
