defmodule Sptfy.OAuthTest do
  use ExUnit.Case, async: true

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
    @tag :skip
    test "exchange code with tokens" do
      Sptfy.OAuth.get_token(%{
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        redirect_uri: "https://redirect.uri/callback",
        code: "CODE"
      })
    end
  end
end
