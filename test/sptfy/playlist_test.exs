defmodule Sptfy.PlaylistTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Playlist
  alias Sptfy.Object.{FullPlaylist, Image, Paging, PlaylistTrack, SimplifiedPlaylist}

  describe "get_my_playlists/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.simplified_playlist())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/playlists", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: [%SimplifiedPlaylist{}]}} = Playlist.get_my_playlists("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/playlists", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_my_playlists("token")
      end
    end
  end

  describe "get_user_playlists/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.simplified_playlist())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc/playlists", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: [%SimplifiedPlaylist{}]}} = Playlist.get_user_playlists("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc/playlists", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_user_playlists("token", id: "abc")
      end
    end
  end

  describe "create_user_playlist/2" do
    test "returns a Playlist struct" do
      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/users/abc/playlists", _, _ -> MockHelpers.response(Fixtures.full_playlist()) end do
        assert {:ok, %FullPlaylist{}} = Playlist.create_user_playlist("token", id: "abc", name: "Playlist")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/users/abc/playlists", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.create_user_playlist("token", id: "abc", name: "Playlist")
      end
    end
  end

  describe "get_playlist/2" do
    test "returns a FullPlaylist struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc", _ -> MockHelpers.response(Fixtures.full_playlist()) end do
        assert {:ok, %FullPlaylist{}} = Playlist.get_playlist("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_playlist("token", id: "abc")
      end
    end
  end

  describe "update_playlist_details/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Playlist.update_playlist_details("token", id: "abc", name: "Playlist")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.update_playlist_details("token", id: "abc", name: "Playlist")
      end
    end
  end

  describe "get_playlist_tracks/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.playlist_track())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/tracks", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: [%PlaylistTrack{}]}} = Playlist.get_playlist_tracks("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/tracks", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_playlist_tracks("token", id: "abc")
      end
    end
  end

  describe "replace_tracks/3" do
    test "returns :ok" do
      json = %{"snapshot_id" => "SNAPSHOT_ID"}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert :ok == Playlist.replace_tracks("token", id: "abc", uris: ["uri"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.replace_tracks("token", id: "abc", uris: ["uri"])
      end
    end
  end

  describe "reorder_tracks/3" do
    test "returns :ok" do
      json = %{"snapshot_id" => "SNAPSHOT_ID"}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert :ok == Playlist.reorder_tracks("token", id: "abc", range_start: 0, insert_before: 5)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.reorder_tracks("token", id: "abc", range_start: 0, insert_before: 5)
      end
    end
  end

  describe "add_tracks/2" do
    test "returns :ok" do
      json = %{"snapshot_id" => "SNAPSHOT_ID"}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert :ok == Playlist.add_tracks("token", id: "abc", uris: ["uri"], position: 1)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.add_tracks("token", id: "abc", uris: ["uri"], position: 1)
      end
    end
  end

  describe "get_cover_images/2" do
    test "returns a list of Image structs" do
      json = [Fixtures.image()]

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/images", _ -> MockHelpers.response(json) end do
        assert {:ok, [%Image{}]} = Playlist.get_cover_images("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/playlists/abc/images", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_cover_images("token", id: "abc")
      end
    end
  end

  describe "upload_cover_image/3" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put_jpeg: fn _, "/v1/playlists/abc/images", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Playlist.upload_cover_image("token", "base64", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put_jpeg: fn _, "/v1/playlists/abc/images", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.upload_cover_image("token", "base64", id: "abc")
      end
    end
  end

  describe "remove_tracks/2" do
    test "returns :ok" do
      json = %{"snapshot_id" => "SNAPSHOT_ID"}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert :ok == Playlist.remove_tracks("token", id: "abc", tracks: [%{uri: "uri"}])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/playlists/abc/tracks", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.remove_tracks("token", id: "abc", tracks: [%{uri: "uri"}])
      end
    end
  end
end
