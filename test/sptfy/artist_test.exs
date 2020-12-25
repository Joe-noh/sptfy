defmodule Sptfy.ArtistTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Artist
  alias Sptfy.Object.FullArtist

  describe "get_artists/2" do
    test "returns list of FullArtist structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists", _ -> TestHelpers.response(artists_json()) end do
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
    test "returns a FullArtist structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/artists/abc", _ -> TestHelpers.response(artist_json()) end do
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

  defp artists_json do
    %{"artists" => [artist_json()]}
  end

  defp artist_json do
    %{
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
      },
      "followers" => %{
        "href" => nil,
        "total" => 633494
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
end
