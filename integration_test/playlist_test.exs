defmodule IntegrationTest.PlaylistTest do
  use ExUnit.Case

  alias Sptfy.Playlist
  alias Sptfy.Object.{FullPlaylist, Paging, SimplifiedPlaylist}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), user_id: "spotify", playlist_id: "37i9dQZF1DX4UtSsGT1Sbe"}
  end

  test "get_my_playlists/2", %{token: token} do
    assert {:ok, %Paging{items: playlists}} = Playlist.get_my_playlists(token)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
  end

  test "get_user_playlists/2", %{token: token, user_id: user_id} do
    assert {:ok, %Paging{items: playlists}} = Playlist.get_user_playlists(token, id: user_id)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
  end

  test "get_playlist/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, %FullPlaylist{}} = Playlist.get_playlist(token, id: playlist_id)
  end
end
