defmodule IntegrationTest.PlaylistTest do
  use ExUnit.Case

  alias Sptfy.Playlist
  alias Sptfy.Object.{FullPlaylist, Image, Paging, PlaylistTrack, SimplifiedPlaylist}

  setup_all do
    %{
      token: System.fetch_env!("SPOTIFY_TOKEN"),
      user_id: "spotify",
      playlist_id: "37i9dQZF1DX4UtSsGT1Sbe",
      my_id: "a6rtpo5jk0qf3hrobms1mhax3",
      my_playlist_id: "5v7vKGGMD5KmRjGyQFCLA0",
      uris: ["spotify:track:4kHQ0zJBMwlb8mKcvvgEqg"]
    }
  end

  test "get_my_playlists/2", %{token: token} do
    assert {:ok, %Paging{items: playlists}} = Playlist.get_my_playlists(token)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
  end

  test "get_user_playlists/2", %{token: token, user_id: user_id} do
    assert {:ok, %Paging{items: playlists}} = Playlist.get_user_playlists(token, id: user_id)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
  end

  @tag skip: "has side effect"
  test "create_user_playlist/2", %{token: token, my_id: my_id} do
    assert {:ok, %FullPlaylist{}} = Playlist.create_user_playlist(token, id: my_id, name: "The Best Playlist")
  end

  test "get_playlist/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, %FullPlaylist{}} = Playlist.get_playlist(token, id: playlist_id)
  end

  test "get_playlist_tracks/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, %Paging{items: tracks}} = Playlist.get_playlist_tracks(token, id: playlist_id)
    assert Enum.all?(tracks, fn track -> %PlaylistTrack{} = track end)
  end

  @tag skip: "has side effect"
  test "add_tracks/2", %{token: token, my_playlist_id: my_playlist_id, uris: uris} do
    assert :ok = Playlist.add_tracks(token, id: my_playlist_id, uris: uris, position: 1)
  end

  test "get_cover_images/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, images} = Playlist.get_cover_images(token, id: playlist_id)
    assert Enum.all?(images, fn image -> %Image{} = image end)
  end
end