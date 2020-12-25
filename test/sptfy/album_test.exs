defmodule Sptfy.AlbumTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Album
  alias Sptfy.Object.{FullAlbum, Paging, SimplifiedTrack}

  describe "get_albums/2" do
    test "returns list of FullAlbum structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums", _ -> TestHelpers.response(albums_json()) end do
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
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc", _ -> TestHelpers.response(album_json()) end do
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
    test "returns a FullAlbum struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/albums/abc/tracks", _ -> TestHelpers.response(paging_tracks_json()) end do
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

  defp albums_json do
    %{"albums" => [album_json()]}
  end

  defp album_json do
    %{
      "album_type" => "compilation",
      "artists" => [
        %{
          "external_urls" => %{
            "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
          },
          "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
          "id" => "ARTIST_ID",
          "name" => "ARTIST NAME",
          "type" => "artist",
          "uri" => "spotify:artist:ARTIST_ID"
        }
      ],
      "available_markets" => ["US"],
      "copyrights" => [%{"text" => "COPYRIGHTS", "type" => "C"}],
      "external_ids" => %{"upc" => "UPC"},
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/album/ALBUM_ID"
      },
      "genres" => [],
      "href" => "https://api.spotify.com/v1/albums/ALBUM_ID",
      "id" => "ALBUM_ID",
      "images" => [
        %{
          "height" => 640,
          "url" => "https://i.scdn.co/image/...",
          "width" => 640
        },
        %{
          "height" => 300,
          "url" => "https://i.scdn.co/image/...",
          "width" => 300
        },
        %{
          "height" => 64,
          "url" => "https://i.scdn.co/image/...",
          "width" => 64
        }
      ],
      "label" => "LABEL",
      "name" => "ALBUM NAME",
      "popularity" => 42,
      "release_date" => "1995",
      "release_date_precision" => "year",
      "total_tracks" => 3,
      "tracks" => paging_tracks_json(),
      "type" => "album",
      "uri" => "spotify:album:ALBUM_ID"
    }
  end

  defp track_json do
    %{
      "artists" => [
        %{
          "external_urls" => %{
            "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
          },
          "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
          "id" => "ARTIST_ID",
          "name" => "ARTIST NAME",
          "type" => "artist",
          "uri" => "spotify:artist:ARTIST_ID"
        }
      ],
      "available_markets" => ["US"],
      "disc_number" => 1,
      "duration_ms" => 1_055_933,
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/track/TRACK_ID"
      },
      "href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "id" => "TRACK_ID",
      "is_local" => false,
      "name" => "TRACK NAME",
      "preview_url" => "https://p.scdn.co/mp3-preview/...",
      "track_number" => 1,
      "type" => "track",
      "uri" => "spotify:track:TRACK_ID"
    }
  end

  defp paging_tracks_json do
    %{
      "href" => "https://api.spotify.com/v1/albums/ALBUM_ID/tracks?offset=0&limit=50",
      "items" => [track_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end
end
