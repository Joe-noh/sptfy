defmodule Sptfy.ArtistTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Artist
  alias Sptfy.Object.{FullArtist, FullTrack, Paging, SimplifiedAlbum}

  describe "get_artists/2" do
    test "returns list of FullArtist structs" do
      json = %{"artists" => [Fixtures.full_artist()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists", _ -> TestHelpers.response(json) end do
        assert {:ok, [%FullArtist{}]} = Artist.get_artists("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Artist.get_artists("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_artist/2" do
    test "returns a FullArtist struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc", _ -> TestHelpers.response(Fixtures.full_artist()) end do
        assert {:ok, %FullArtist{}} = Artist.get_artist("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Artist.get_artist("token", id: "abc")
      end
    end
  end

  describe "get_top_tracks/2" do
    test "returns a list of FullTrack structs" do
      json = %{"tracks" => [Fixtures.full_track()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/top-tracks", _ -> TestHelpers.response(json) end do
        assert {:ok, [%FullTrack{}]} = Artist.get_top_tracks("token", id: "abc", market: "US")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/top-tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Artist.get_top_tracks("token", id: "abc", market: "US")
      end
    end
  end

  describe "get_related_artists/2" do
    test "returns a list of FullArtist structs" do
      json = %{"artists" => [Fixtures.full_artist()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/related-artists", _ -> TestHelpers.response(json) end do
        assert {:ok, [%FullArtist{}]} = Artist.get_related_artists("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/related-artists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Artist.get_related_artists("token", id: "abc")
      end
    end
  end

  describe "get_albums/2" do
    test "returns a Paging structs" do
      json = Fixtures.paging(Fixtures.simplified_album())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/albums", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: [%SimplifiedAlbum{}]}} = Artist.get_albums("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc/albums", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Artist.get_albums("token", id: "abc")
      end
    end
  end
end
