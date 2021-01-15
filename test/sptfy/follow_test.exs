defmodule Sptfy.FollowTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Follow
  alias Sptfy.Object.{FullArtist, Paging}

  describe "follow_playlist/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/followers", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.follow_playlist("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/followers", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.follow_playlist("token", id: "abc")
      end
    end
  end

  describe "unfollow_playlist/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/playlists/abc/followers", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.unfollow_playlist("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/playlists/abc/followers", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.unfollow_playlist("token", id: "abc")
      end
    end
  end

  describe "check_playlist_following_state/2" do
    test "returns list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/followers/contains", _ -> MockHelpers.response([true]) end do
        assert {:ok, [true]} == Follow.check_playlist_following_state("token", id: "abc", ids: ["def"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/followers/contains", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.check_playlist_following_state("token", id: "abc", ids: ["def"])
      end
    end
  end

  describe "get_my_following_artists/2" do
    test "returns a Paging struct" do
      json = %{"artists" => Fixtures.paging(Fixtures.full_artist())}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: [%FullArtist{}]}} = Follow.get_my_following_artists("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.get_my_following_artists("token")
      end
    end
  end

  describe "follow_users/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/following", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.follow_users("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/following", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.follow_users("token", ids: ["abc"])
      end
    end
  end

  describe "follow_artists/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/following", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.follow_artists("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/following", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.follow_artists("token", ids: ["abc"])
      end
    end
  end

  describe "unfollow_users/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/following", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.unfollow_users("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/following", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.unfollow_users("token", ids: ["abc"])
      end
    end
  end

  describe "unfollow_artists/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/following", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Follow.unfollow_artists("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/following", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.unfollow_artists("token", ids: ["abc"])
      end
    end
  end

  describe "check_my_user_following_state/2" do
    test "returns list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following/contains", _ -> MockHelpers.response([true]) end do
        assert {:ok, [true]} == Follow.check_my_user_following_state("token", ids: ["def"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following/contains", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.check_my_user_following_state("token", ids: ["def"])
      end
    end
  end

  describe "check_my_artist_following_state/2" do
    test "returns list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following/contains", _ -> MockHelpers.response([true]) end do
        assert {:ok, [true]} == Follow.check_my_artist_following_state("token", ids: ["def"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/following/contains", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Follow.check_my_artist_following_state("token", ids: ["def"])
      end
    end
  end
end
