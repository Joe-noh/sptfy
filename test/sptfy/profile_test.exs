defmodule Sptfy.ProfileTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Profile
  alias Sptfy.Object.{PrivateUser, PublicUser}

  describe "get_my_profile/2" do
    test "returns a PrivateUser struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me", _ -> TestHelpers.response(private_profile_json()) end do
        assert {:ok, %PrivateUser{}} = Profile.get_my_profile("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Profile.get_my_profile("token")
      end
    end
  end

  describe "get_profile/2" do
    test "returns a PublicUser struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc", _ -> TestHelpers.response(public_profile_json()) end do
        assert {:ok, %PublicUser{}} = Profile.get_profile("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Profile.get_profile("token", id: "abc")
      end
    end
  end

  defp private_profile_json do
    %{
      "country" => "US",
      "display_name" => "DISPLAY NAME",
      "email" => "email@example.com",
      "explicit_content" => %{"filter_enabled" => false, "filter_locked" => false},
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/user/USER_ID"
      },
      "followers" => %{"href" => nil, "total" => 2},
      "href" => "https://api.spotify.com/v1/users/USER_ID",
      "id" => "USER_ID",
      "images" => [
        %{
          "height" => nil,
          "url" => "https://i.scdn.co/image/...",
          "width" => nil
        }
      ],
      "product" => "premium",
      "type" => "user",
      "uri" => "spotify:user:USER_ID"
    }
  end

  defp public_profile_json do
    %{
      "display_name" => "DISPLAY NAME",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/user/USER_ID"
      },
      "followers" => %{"href" => nil, "total" => 2},
      "href" => "https://api.spotify.com/v1/users/USER_ID",
      "id" => "USER_ID",
      "images" => [
        %{
          "height" => nil,
          "url" => "https://i.scdn.co/image/...",
          "width" => nil
        }
      ],
      "type" => "user",
      "uri" => "spotify:user:USER_ID"
    }
  end
end
