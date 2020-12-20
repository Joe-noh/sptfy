defmodule Sptfy.OAuth do
  @type response :: {:ok, Finch.Response.t()} | {:error, OAuthError.t()} | {:error, Mint.Types.error()}

  alias Sptfy.Object.OAuthResponse
  alias Sptfy.Object.OAuthError

  @doc """
  Returns a URL to request an authorization code.

      iex> Sptfy.OAuth.url("CLIENT_ID", "https://example.com/callback")
      ...> "https://accounts.spotify.com/authorize?client_id=CLIENT_ID&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&response_type=code&scope="

      iex> Sptfy.OAuth.url("CLIENT_ID", "https://example.com/callback", %{scope: ["streaming"]})
      ...> "https://accounts.spotify.com/authorize?client_id=CLIENT_ID&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&response_type=code&scope=streaming"
  """
  @spec url(client_id :: String.t(), redirect_uri :: String.t(), params :: map()) :: String.t()
  def url(client_id, redirect_uri, params \\ %{}) do
    scope = Map.get(params, :scope, []) |> Enum.join(",")

    endpoint = "https://accounts.spotify.com/authorize"
    query = Map.merge(params, %{response_type: "code", client_id: client_id, redirect_uri: redirect_uri, scope: scope})

    endpoint <> "?" <> URI.encode_query(query)
  end

  @doc """
  Requests access token and refresh token to the Spotify Accounts service.
  """
  @spec get_token(client_id :: String.t(), client_secret :: String.t(), code :: String.t(), redirect_uri :: String.t()) :: response()
  def get_token(client_id, client_secret, code, redirect_uri) do
    post(client_id, client_secret, grant_type: "authorization_code", code: code, redirect_uri: redirect_uri)
  end

  @doc """
  Exchanges a refresh token for new access token.
  """
  @spec refresh_token(client_id :: String.t(), client_secret :: String.t(), refresh_token :: String.t()) :: response()
  def refresh_token(client_id, client_secret, refresh_token) do
    post(client_id, client_secret, grant_type: "refresh_token", refresh_token: refresh_token)
  end

  @spec post(client_id :: String.t(), client_secret :: String.t(), body :: Keyword.t()) :: response()
  defp post(client_id, client_secret, body) do
    endpoint = "https://accounts.spotify.com/api/token"
    headers = headers(client_id, client_secret)
    body = URI.encode_query(body)

    Finch.build(:post, endpoint, headers, body)
    |> Finch.request(Sptfy.Finch)
    |> case do
      {:ok, response} -> handle_response(response)
      error -> error
    end
  end

  defp headers(client_id, client_secret) do
    [
      {"Authorization", "Basic " <> Base.encode64(client_id <> ":" <> client_secret)},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
  end

  defp handle_response(%Finch.Response{status: status, body: body}) when status in 200..299 do
    {:ok, body} = Jason.decode(body)
    {:ok, OAuthResponse.new(body)}
  end

  defp handle_response(%Finch.Response{status: status, body: body}) when status in 400..499 do
    {:ok, body} = Jason.decode(body)
    {:error, OAuthError.new(body)}
  end
end
