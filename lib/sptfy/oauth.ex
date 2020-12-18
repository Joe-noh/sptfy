defmodule Sptfy.OAuth do
  def url(client_id, redirect_uri, params \\ %{}) do
    scope = Map.get(params, :scope, []) |> Enum.join(",")

    endpoint = "https://accounts.spotify.com/authorize"
    query = Map.merge(params, %{response_type: "code", client_id: client_id, redirect_uri: redirect_uri, scope: scope})

    endpoint <> "?" <> URI.encode_query(query)
  end

  def get_token(client_id, client_secret, code, redirect_uri) do
    post(client_id, client_secret, grant_type: "authorization_code", code: code, redirect_uri: redirect_uri)
  end

  def refresh_token(client_id, client_secret, refresh_token) do
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
