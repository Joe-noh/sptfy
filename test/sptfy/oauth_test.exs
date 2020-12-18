defmodule Sptfy.OAuthTest do
  use ExUnit.Case, async: false

  import Mock

  describe "url/1" do
    setup do
      params = [
        client_id: "CLIENT_ID",
        redirect_uri: "https://redirect.uri/callback",
        scope: ~w[SCOPE1 SCOPE2],
        state: "STATE",
        show_dialog: true
      ]

      %{params: params}
    end

    test "returns authorize URL", %{params: params} do
      uri = Sptfy.OAuth.url(params) |> URI.parse()

      assert uri.scheme == "https"
      assert uri.host == "accounts.spotify.com"
      assert uri.path == "/authorize"

      expected_query = %{
        "client_id" => "CLIENT_ID",
        "redirect_uri" => "https://redirect.uri/callback",
        "response_type" => "code",
        "scope" => "SCOPE1,SCOPE2",
        "show_dialog" => "true",
        "state" => "STATE"
      }

      assert expected_query == URI.decode_query(uri.query)
    end

    test "accept params as a map", %{params: params} do
      map_params = params |> Enum.into(%{})

      assert Sptfy.OAuth.url(params) == Sptfy.OAuth.url(map_params)
    end
  end

  describe "get_token/1" do
    test "exchange code with tokens" do
      response_body = token_json() |> Jason.encode!()

      params = %{
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        redirect_uri: "https://redirect.uri/callback",
        code: "CODE"
      }

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %{body: response_body}} end do
        assert {:ok, response} = Sptfy.OAuth.get_token(params)
        assert response.access_token == "ACCESS_TOKEN"
        assert response.token_type == "Bearer"
        assert response.scope == ~w[user-read-private user-read-email]
        assert response.expires_in == 3600
        assert response.refresh_token == "REFRESH_TOKEN"
      end
    end
  end

  describe "refresh_token/1" do
    test "get new access token" do
      response_body = token_json() |> Map.delete("refresh_token") |> Jason.encode!()

      params = %{
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        refresh_token: "REFRESH_TOKEN"
      }

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %{body: response_body}} end do
        assert {:ok, response} = Sptfy.OAuth.refresh_token(params)
        assert response.access_token == "ACCESS_TOKEN"
        assert response.token_type == "Bearer"
        assert response.scope == ~w[user-read-private user-read-email]
        assert response.expires_in == 3600
        assert response.refresh_token == nil
      end
    end
  end

  defp token_json do
    %{
      "access_token" => "ACCESS_TOKEN",
      "token_type" => "Bearer",
      "scope" => "user-read-private user-read-email",
      "expires_in" => 3600,
      "refresh_token" => "REFRESH_TOKEN"
    }
  end
end
