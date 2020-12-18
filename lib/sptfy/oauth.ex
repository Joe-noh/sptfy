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
    post(client_id, client_secret, grant_type: "authorization_code", code: code, redirect_uri: redirect_uri)
  end

  def refresh_token(params) when is_list(params) do
    params |> Enum.into(%{}) |> refresh_token()
  end

  def refresh_token(%{client_id: client_id, client_secret: client_secret, refresh_token: refresh_token}) do
    post(client_id, client_secret, grant_type: "refresh_token", refresh_token: refresh_token)
  end

  defp post(client_id, client_secret, body) do
    endpoint = "https://accounts.spotify.com/api/token"
    headers = headers(client_id, client_secret)
    body = URI.encode_query(body)

    Finch.build(:post, endpoint, headers, body)
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
