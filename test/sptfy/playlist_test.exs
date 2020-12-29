defmodule Sptfy.PlaylistTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Playlist
  alias Sptfy.Object.{Paging, SimplifiedPlaylist}

  describe "get_my_playlists/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/playlists", _ -> TestHelpers.response(paging_playlists_json()) end do
        assert {:ok, %Paging{items: [%SimplifiedPlaylist{}]}} = Playlist.get_my_playlists("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/playlists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_my_playlists("token")
      end
    end
  end

  describe "get_user_playlists/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc/playlists", _ -> TestHelpers.response(paging_playlists_json()) end do
        assert {:ok, %Paging{items: [%SimplifiedPlaylist{}]}} = Playlist.get_user_playlists("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/users/abc/playlists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Playlist.get_user_playlists("token", id: "abc")
      end
    end
  end

  defp paging_playlists_json do
    %{
      "href" => "https://api.spotify.com/v1/users/USER_ID/playlists?offset=0&limit=20",
      "items" => [playlist_json()],
      "limit" => 20,
      "next" => "https://api.spotify.com/v1/users/USER_ID/playlists?offset=20&limit=20",
      "offset" => 0,
      "previous" => nil,
      "total" => 1412
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
end
