defmodule Sptfy.OAuth do
  def url(params) when is_list(params) do
    params |> Enum.into(%{}) |> url()
  end

  def url(params) do
    scope = Map.get(params, :scope, []) |> Enum.join(",")

    endpoint = "https://accounts.spotify.com/authorize"
    query = Map.merge(params, %{response_type: "code", scope: scope})

    endpoint <> "?" <> URI.encode_query(query)
  end

  def get_token(params) when is_list(params) do
    params |> Enum.into(%{}) |> get_token()
  end

  def get_token(%{client_id: client_id, client_secret: client_secret, code: code, redirect_uri: redirect_uri}) do
    endpoint = "https://accounts.spotify.com/api/token"
    body = URI.encode_query(grant_type: "authorization_code", code: code, redirect_uri: redirect_uri)

    Finch.build(:post, endpoint, headers(client_id, client_secret), body)
    |> Finch.request(Sptfy.Finch)
    |> case do
      {:ok, %{body: body}} ->
        {:ok, body} = Jason.decode(body)
        {:ok, Sptfy.OAuth.Response.new(body)}

      error ->
        error
    end
  end

  def refresh_token(params) when is_list(params) do
    params |> Enum.into(%{}) |> refresh_token()
  end

  def refresh_token(%{client_id: client_id, client_secret: client_secret, refresh_token: refresh_token}) do
    endpoint = "https://accounts.spotify.com/api/token"
    body = URI.encode_query(grant_type: "refresh_token", refresh_token: refresh_token)

    Finch.build(:post, endpoint, headers(client_id, client_secret), body)
    |> Finch.request(Sptfy.Finch)
    |> case do
      {:ok, %{body: body}} ->
        {:ok, body} = Jason.decode(body)
        {:ok, Sptfy.OAuth.Response.new(body)}

      error ->
        error
    end
  end

  defp headers(client_id, client_secret) do
    [
      {"Authorization", "Basic " <> Base.encode64(client_id <> ":" <> client_secret)},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
  end
end
