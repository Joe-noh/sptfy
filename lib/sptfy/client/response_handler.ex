defmodule Sptfy.Client.ResponseHandler do
  @moduledoc false

  def handle(%Finch.Response{body: body}, mapping) do
    json = Jason.decode!(body)

    case Map.get(json, "error") do
      nil -> handle_response(json, mapping)
      error -> handle_error(error)
    end
  end

  defp handle_response(json, mapping) do
    {:ok, Sptfy.Client.BodyMapper.map(json, mapping)}
  end

  defp handle_error(json) do
    {:error, Sptfy.Object.Error.new(json)}
  end
end
