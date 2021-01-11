defmodule Sptfy.BrowseTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Browse
  alias Sptfy.Object.{Paging, SimplifiedAlbum}

  describe "get_new_releases/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/new-releases", _ -> TestHelpers.response(%{"albums" => paging_albums_json()}) end do
        assert {:ok, %Paging{items: albums}} = Browse.get_new_releases("token")
        assert Enum.all?(albums, fn album -> %SimplifiedAlbum{} = album end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/new-releases", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_new_releases("token")
      end
    end
  end

  defp paging_albums_json do
    %{
      "href" => "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=50",
      "items" => [album_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
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
