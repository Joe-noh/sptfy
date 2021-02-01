defmodule Sptfy.Client.ResponseHandler do
  @moduledoc false

  alias Sptfy.Client.BodyMapper
  alias Sptfy.Object.Error

  @type handled_response :: BodyMapper.mapped_result() | {:error, Error.t()}

  @spec handle(response :: %Finch.Response{}, mapping :: BodyMapper.mapping()) :: handled_response()
  def handle(%Finch.Response{body: body}, mapping) do
    case Jason.decode(body) do
      {:ok, json} -> handle_json(json, mapping)
      {:error, _} -> handle_json(%{}, mapping)
    end
  end

  defp handle_json(json, mapping) when is_map(json) do
    case Map.get(json, "error") do
      nil -> BodyMapper.map(json, mapping)
      error -> {:error, Error.new(error)}
    end
  end

  defp handle_json(json, mapping) when is_list(json) do
    BodyMapper.map(json, mapping)
  end
end
