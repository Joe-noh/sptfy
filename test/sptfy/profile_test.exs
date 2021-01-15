defmodule Sptfy.ProfileTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Profile
  alias Sptfy.Object.{PrivateUser, PublicUser}

  describe "get_my_profile/2" do
    test "returns a PrivateUser struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me", _ -> MockHelpers.response(Fixtures.private_profile()) end do
        assert {:ok, %PrivateUser{}} = Profile.get_my_profile("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Profile.get_my_profile("token")
      end
    end
  end

  describe "get_profile/2" do
    test "returns a PublicUser struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc", _ -> MockHelpers.response(Fixtures.public_profile()) end do
        assert {:ok, %PublicUser{}} = Profile.get_profile("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Profile.get_profile("token", id: "abc")
      end
    end
  end
end
