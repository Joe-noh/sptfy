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

  @tag skip: "has side effect"
  test "update_playlist_details/2", %{token: token, my_playlist_id: my_playlist_id} do
    assert :ok = Playlist.update_playlist_details(token, id: my_playlist_id, name: "Awesome Playlist")
  end

  test "get_playlist_tracks/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, %Paging{items: tracks}} = Playlist.get_playlist_tracks(token, id: playlist_id)
    assert Enum.all?(tracks, fn track -> %PlaylistTrack{} = track end)
  end

  @tag skip: "has side effect"
  test "replace_tracks/2", %{token: token, my_playlist_id: my_playlist_id, uris: uris} do
    assert :ok = Playlist.replace_tracks(token, id: my_playlist_id, uris: uris)
  end

  @tag skip: "has side effect"
  test "reorder_tracks/2", %{token: token, my_playlist_id: my_playlist_id} do
    assert :ok = Playlist.reorder_tracks(token, id: my_playlist_id, range_start: 0, insert_before: 3)
  end

  @tag skip: "has side effect"
  test "add_tracks/2", %{token: token, my_playlist_id: my_playlist_id, uris: uris} do
    assert :ok = Playlist.add_tracks(token, id: my_playlist_id, uris: uris, position: 1)
  end

  test "get_cover_images/2", %{token: token, playlist_id: playlist_id} do
    assert {:ok, images} = Playlist.get_cover_images(token, id: playlist_id)
    assert Enum.all?(images, fn image -> %Image{} = image end)
  end

  @tag skip: "has side effect"
  test "upload_cover_image/3", %{token: token, my_playlist_id: my_playlist_id} do
    base64 = """
    /9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRE
    NDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
    AQEBAQEBAQEBAQEBAQEBD/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAn/xAAUEAEAAAAAAAAAA
    AAAAAAAAAAA/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AKpgA//Z
    """
    body = String.replace(base64, "\n", "")

    assert :ok == Playlist.upload_cover_image(token, body, id: my_playlist_id)
  end
end
