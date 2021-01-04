defmodule Sptfy.Client.HTTP do
  @moduledoc false

  @spec get(token :: String.t(), path :: String.t(), query :: map()) :: {:ok, Finch.Response.t()} | {:error, Mint.Types.error()}
  def get(token, path, query) do
    url = url(path, query)
    headers = json_headers(token)

    Finch.build(:get, url, headers) |> Finch.request(Sptfy.Finch)
  end

  @spec post(token :: String.t(), path :: String.t(), query :: map(), body :: map()) :: {:ok, Finch.Response.t()} | {:error, Mint.Types.error()}
  def post(token, path, query, body) do
    url = url(path, query)
    headers = json_headers(token)
    body = Jason.encode!(body)

    Finch.build(:post, url, headers, body) |> Finch.request(Sptfy.Finch)
  end

  @spec put(token :: String.t(), path :: String.t(), query :: map(), body :: map()) :: {:ok, Finch.Response.t()} | {:error, Mint.Types.error()}
  def put(token, path, query, body) do
    url = url(path, query)
    headers = json_headers(token)
    body = Jason.encode!(body)

    Finch.build(:put, url, headers, body) |> Finch.request(Sptfy.Finch)
  end

  @spec put_jpeg(token :: String.t(), path :: String.t(), query :: map(), body :: binary()) :: {:ok, Finch.Response.t()} | {:error, Mint.Types.error()}
  def put_jpeg(token, path, query, body) do
    url = url(path, query)
    headers = jpeg_headers(token)

    Finch.build(:put, url, headers, body) |> Finch.request(Sptfy.Finch)
  end

  defp url(path, query) do
    "https://api.spotify.com" <> path <> "?" <> query_string(query)
  end

  defp json_headers(token) do
    [{"Authorization", "Bearer " <> token}, {"Content-Type", "application/json"}]
  end

  defp jpeg_headers(token) do
    [{"Authorization", "Bearer " <> token}, {"Content-Type", "image/jpeg"}]
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
