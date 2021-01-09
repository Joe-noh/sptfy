defmodule Sptfy.LibraryTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Library
  alias Sptfy.Object.{Paging, SavedAlbum, SavedShow, SavedTrack}

  describe "get_saved_albums/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums", _ -> TestHelpers.response(paging_saved_albums_json()) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_albums("token")
        assert Enum.all?(items, fn item -> %SavedAlbum{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_albums("token")
      end
    end
  end

  describe "get_saved_tracks/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks", _ -> TestHelpers.response(paging_saved_tracks_json()) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_tracks("token")
        assert Enum.all?(items, fn item -> %SavedTrack{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_tracks("token")
      end
    end
  end

  describe "get_saved_shows/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows", _ -> TestHelpers.response(paging_saved_shows_json()) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_shows("token")
        assert Enum.all?(items, fn item -> %SavedShow{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_shows("token")
      end
    end
  end

  defp paging_saved_albums_json do
    %{
      "href" => "https://api.spotify.com/v1/me/albums?offset=0&limit=50",
      "items" => [saved_album_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end

  defp paging_saved_tracks_json do
    %{
      "href" => "https://api.spotify.com/v1/me/tracks?offset=0&limit=50",
      "items" => [saved_track_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end

  defp paging_saved_shows_json do
    %{
      "href" => "https://api.spotify.com/v1/me/shows?offset=0&limit=50",
      "items" => [saved_show_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end

  defp saved_album_json do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "album" => album_json()
    }
  end

  defp saved_track_json do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "track" => track_json()
    }
  end

  defp saved_show_json do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "show" => show_json()
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
      "tracks" => [],
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

  defp show_json do
    %{
      "available_markets" => ["US"],
      "copyrights" => [],
      "description" => "SHOW DESCRIPTION",
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/show/SHOW_ID"
      },
      "href" => "https://api.spotify.com/v1/shows/SHOW_ID",
      "id" => "SHOW_ID",
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
      "is_externally_hosted" => false,
      "languages" => ["en"],
      "media_type" => "audio",
      "name" => "SHOW NAME",
      "publisher" => "SHOW PUBLISHER",
      "total_episodes" => 500,
      "type" => "show",
      "uri" => "spotify:show:SHOW_ID"
    }
  end
end
