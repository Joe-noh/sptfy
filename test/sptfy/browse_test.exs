defmodule Sptfy.BrowseTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Browse
  alias Sptfy.Object.{Category, Paging, Recommendation, SimplifiedAlbum, SimplifiedPlaylist}

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

  describe "get_featured_playlists/2" do
    test "returns a Paging struct with message" do
      json = %{"message" => "MESSAGE", "playlists" => paging_playlists_json()}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/featured-playlists", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: albums}, "MESSAGE"} = Browse.get_featured_playlists("token")
        assert Enum.all?(albums, fn album -> %SimplifiedPlaylist{} = album end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/featured-playlists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_featured_playlists("token")
      end
    end
  end

  describe "get_categories/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories", _ -> TestHelpers.response(%{"categories" => paging_categories_json()}) end do
        assert {:ok, %Paging{items: categories}} = Browse.get_categories("token")
        assert Enum.all?(categories, fn category -> %Category{} = category end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_categories("token")
      end
    end
  end

  describe "get_category/2" do
    test "returns a Category struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc", _ -> TestHelpers.response(category_json()) end do
        assert {:ok, %Category{}} = Browse.get_category("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_category("token", id: "abc")
      end
    end
  end

  describe "get_category_playlists/2" do
    test "returns a Category struct" do
      json = %{"playlists" => paging_playlists_json()}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc/playlists", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: playlists}} = Browse.get_category_playlists("token", id: "abc")
        assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc/playlists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_category_playlists("token", id: "abc")
      end
    end
  end

  describe "get_recommendations/2" do
    test "returns a Recommendation struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations", _ -> TestHelpers.response(recommendation_json()) end do
        assert {:ok, %Recommendation{}} = Browse.get_recommendations("token", seed_artists: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_recommendations("token", seed_artists: ["abc"])
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

  defp paging_playlists_json do
    %{
      "href" => "https://api.spotify.com/v1/browse/featured-playlists?offset=0&limit=50",
      "items" => [playlist_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 10
    }
  end

  defp playlist_json do
    %{
      "collaborative" => false,
      "description" => "PLAYLIST DESCRIPTION",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/playlist/PLAYLIST_ID"
      },
      "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID",
      "id" => "PLAYLIST_ID",
      "images" => [
        %{
          "height" => nil,
          "url" => "https://i.scdn.co/image/...",
          "width" => nil
        }
      ],
      "name" => "PLAYLIST NAME",
      "owner" => %{
        "display_name" => "Spotify",
        "external_urls" => %{
          "spotify" => "https://open.spotify.com/user/USER_ID"
        },
        "href" => "https://api.spotify.com/v1/users/USER_ID",
        "id" => "USER_ID",
        "type" => "user",
        "uri" => "spotify:user:USER_ID"
      },
      "primary_color" => nil,
      "public" => true,
      "snapshot_id" => "SNAPSHOT_ID",
      "tracks" => %{
        "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID/tracks",
        "total" => 50
      },
      "type" => "playlist",
      "uri" => "spotify:playlist:PLAYLIST_ID"
    }
  end

  defp category_json do
    %{
      "href" => "https://api.spotify.com/v1/browse/categories/CATEGORY_ID",
      "icons" => [
        %{
          "height" => 274,
          "url" => "https://t.scdn.co/...",
          "width" => 274
        }
      ],
      "id" => "CATEGORY_ID",
      "name" => "CATEGORY NAME"
    }
  end

  defp paging_categories_json do
    %{
      "href" => "https://api.spotify.com/v1/browse/categories?offset=0&limit=20",
      "items" => [category_json()],
      "limit" => 20,
      "next" => "https://api.spotify.com/v1/browse/categories?offset=20&limit=20",
      "offset" => 0,
      "previous" => nil,
      "total" => 49
    }
  end

  defp recommendation_json do
    %{
      "seeds" => [seed_json()],
      "tracks" => [track_json()]
    }
  end

  defp seed_json do
    %{
      "afterFilteringSize" => 250,
      "afterRelinkingSize" => 250,
      "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
      "id" => "ARTIST_ID",
      "initialPoolSize" => 250,
      "type" => "ARTIST"
    }
  end
end
