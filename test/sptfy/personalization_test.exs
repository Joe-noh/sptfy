defmodule Sptfy.PersonalizationTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Personalization
  alias Sptfy.Object.{FullArtist, FullTrack, Paging}

  describe "get_top_artists/2" do
    test "returns a Paging structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/artists", _ -> TestHelpers.response(paging_artists_json()) end do
        assert {:ok, %Paging{items: [%FullArtist{}]}} = Personalization.get_top_artists("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/artists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Personalization.get_top_artists("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_top_tracks/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/tracks", _ -> TestHelpers.response(paging_tracks_json()) end do
        assert {:ok, %Paging{items: [%FullTrack{}]}} = Personalization.get_top_tracks("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Personalization.get_top_tracks("token", id: "abc")
      end
    end
  end

  defp paging_artists_json do
    %{
      "href" => "https://api.spotify.com/v1/me/top/artists?offset=0&limit=50",
      "items" => [artist_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end

  defp paging_tracks_json do
    %{
      "href" => "https://api.spotify.com/v1/me/top/tracks?offset=0&limit=50",
      "items" => [track_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end

  defp artist_json do
    %{
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
      },
      "followers" => %{
        "href" => nil,
        "total" => 633_494
      },
      "genres" => ["art rock"],
      "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
      "id" => "ARTIST_ID",
      "images" => [
        %{
          "height" => 640,
          "url" => "https://i.scdn.co/image/...",
          "width" => 640
        },
        %{
          "height" => 320,
          "url" => "https://i.scdn.co/image/...",
          "width" => 320
        },
        %{
          "height" => 160,
          "url" => "https://i.scdn.co/image/...",
          "width" => 160
        }
      ],
      "name" => "ARTIST NAME",
      "popularity" => 77,
      "type" => "artist",
      "uri" => "spotify:artist:ARTIST_ID"
    }
  end

  defp track_json do
    %{
      "album" => %{
        "album_type" => "single",
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
        "external_urls" => %{
          "spotify" => "https://open.spotify.com/album/ALBUM_ID"
        },
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
        "name" => "ALBUM NAME",
        "release_date" => "2017-05-26",
        "release_date_precision" => "day",
        "type" => "album",
        "uri" => "spotify:album:ALBUM_ID"
      },
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
      "duration_ms" => 207_959,
      "explicit" => false,
      "external_ids" => %{
        "isrc" => "ISRC"
      },
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/track/TRACK_ID"
      },
      "href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "id" => "TRACK_ID",
      "is_local" => false,
      "name" => "TRACK NAME",
      "popularity" => 63,
      "preview_url" => "https://p.scdn.co/mp3-preview/...",
      "track_number" => 1,
      "type" => "track",
      "uri" => "spotify:track:TRACK_ID"
    }
  end
end
