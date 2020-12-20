defmodule Sptfy.OAuthTest do
  use ExUnit.Case, async: false

  import Mock

  doctest Sptfy.OAuth

  describe "url/1" do
    test "returns authorize URL" do
      url = Sptfy.OAuth.url("CLIENT_ID", "https://redirect.uri/callback", %{scope: ~w[SCOPE1 SCOPE2], state: "STATE", show_dialog: true})
      uri = URI.parse(url)

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
  end

  describe "get_token/1" do
    test "exchange code with tokens" do
      body = token_json() |> Jason.encode!()

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %Finch.Response{status: 200, body: body}} end do
        assert {:ok, response} = Sptfy.OAuth.get_token("CLIENT_ID", "CLIENT_SECRET", "https://redirect.uri/callback", "CODE")
        assert response.access_token == "ACCESS_TOKEN"
        assert response.token_type == "Bearer"
        assert response.scope == ~w[user-read-private user-read-email]
        assert response.expires_in == 3600
        assert response.refresh_token == "REFRESH_TOKEN"
      end
    end

    test "returns OAuthError struct on error" do
      body = error_json() |> Jason.encode!()

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %Finch.Response{status: 400, body: body}} end do
        assert {:error, error} = Sptfy.OAuth.get_token("CLIENT_ID", "CLIENT_SECRET", "https://redirect.uri/callback", "CODE")
        assert error.error == "ERROR"
        assert error.error_description == "DESCRIPTION"
      end
    end
  end

  describe "refresh_token/1" do
    test "get new access token" do
      body = token_json() |> Map.delete("refresh_token") |> Jason.encode!()

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %Finch.Response{status: 200, body: body}} end do
        assert {:ok, response} = Sptfy.OAuth.refresh_token("CLIENT_ID", "CLIENT_SECRET", "REFRESH_TOKEN")
        assert response.access_token == "ACCESS_TOKEN"
        assert response.token_type == "Bearer"
        assert response.scope == ~w[user-read-private user-read-email]
        assert response.expires_in == 3600
        assert response.refresh_token == nil
      end
    end

    test "returns OAuthError struct on error" do
      body = error_json() |> Jason.encode!()

      with_mock Finch, [:passthrough], request: fn _, _ -> {:ok, %Finch.Response{status: 400, body: body}} end do
        assert {:error, error} = Sptfy.OAuth.refresh_token("CLIENT_ID", "CLIENT_SECRET", "REFRESH_TOKEN")
        assert error.error == "ERROR"
        assert error.error_description == "DESCRIPTION"
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

  defp error_json do
    %{
      "error" => "ERROR",
      "error_description" => "DESCRIPTION"
    }
  end
end
