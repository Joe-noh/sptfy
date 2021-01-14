defmodule Sptfy.AlbumTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Album
  alias Sptfy.Object.{FullAlbum, Paging, SimplifiedTrack}

  describe "get_albums/2" do
    test "returns list of FullAlbum structs" do
      json = %{"albums" => [Fixtures.full_album()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums", _ -> TestHelpers.response(json) end do
        assert {:ok, [%FullAlbum{}]} = Album.get_albums("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Album.get_albums("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_album/2" do
    test "returns a FullAlbum struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc", _ -> TestHelpers.response(Fixtures.full_album()) end do
        assert {:ok, %FullAlbum{}} = Album.get_album("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Album.get_album("token", id: "abc")
      end
    end
  end

  describe "get_album_tracks/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.simplified_track())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc/tracks", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: [%SimplifiedTrack{}]}} = Album.get_album_tracks("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc/tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Album.get_album_tracks("token", id: "abc")
      end
    end
  end
end
