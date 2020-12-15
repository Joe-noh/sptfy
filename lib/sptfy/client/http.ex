defmodule Sptfy.Client.HTTP do
  @moduledoc false

  def get(token, path, query) do
    url = url(path, query)
    Finch.build(:get, url, headers(token)) |> Finch.request(Sptfy.Finch)
  end

  defp url(path, query) do
    "https://api.spotify.com" <> path <> "?" <> query_string(query)
  end

  defp headers(token) do
    [{"Authorization", "Bearer " <> token}]
  end

  defp query_string(query) do
    query
    |> Enum.map(fn
      {k, v} when is_list(v) -> {k, Enum.join(v, ",")}
      {k, v} -> {k, v}
    end)
    |> URI.encode_query()
  end
end
