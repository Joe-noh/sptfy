defmodule IntegrationTest.LibraryTest do
  use ExUnit.Case

  alias Sptfy.Library
  alias Sptfy.Object.{Paging, SavedAlbum, SavedShow, SavedTrack}

  setup_all do
    %{
      token: System.fetch_env!("SPOTIFY_TOKEN"),
      album_id: "6BRJZjxYJQEIBn0zb94Aev",
      track_id: "0YP2c4aqvZehpngSGScVkn",
      show_id: "5kzbfQP7m7IoO65LvATIRQ"
    }
  end

  test "get_saved_albums/2", %{token: token} do
    assert {:ok, %Paging{items: albums}} = Library.get_saved_albums(token)
    assert Enum.all?(albums, fn album -> %SavedAlbum{} = album end)
  end

  @tag skip: "has side effect"
  test "save_albums/2", %{token: token, album_id: album_id} do
    assert :ok == Library.save_albums(token, ids: [album_id])
  end

  @tag skip: "has side effect"
  test "remove_from_saved_albums/2", %{token: token, album_id: album_id} do
    assert :ok == Library.remove_from_saved_albums(token, ids: [album_id])
  end

  test "check_albums_saved_state/2", %{token: token, album_id: album_id} do
    assert {:ok, [false]} == Library.check_albums_saved_state(token, ids: [album_id])
  end

  test "get_saved_tracks/2", %{token: token} do
    assert {:ok, %Paging{items: tracks}} = Library.get_saved_tracks(token)
    assert Enum.all?(tracks, fn track -> %SavedTrack{} = track end)
  end

  @tag skip: "has side effect"
  test "save_tracks/2", %{token: token, track_id: track_id} do
    assert :ok == Library.save_tracks(token, ids: [track_id])
  end

  @tag skip: "has side effect"
  test "remove_from_saved_tracks/2", %{token: token, track_id: track_id} do
    assert :ok == Library.remove_from_saved_tracks(token, ids: [track_id])
  end

  test "check_tracks_saved_state/2", %{token: token, track_id: track_id} do
    assert {:ok, [true]} == Library.check_tracks_saved_state(token, ids: [track_id])
  end

  test "get_saved_shows/2", %{token: token} do
    assert {:ok, %Paging{items: shows}} = Library.get_saved_shows(token)
    assert Enum.all?(shows, fn show -> %SavedShow{} = show end)
  end

  @tag skip: "has side effect"
  test "save_shows/2", %{token: token, show_id: show_id} do
    assert :ok == Library.save_shows(token, ids: [show_id])
  end

  @tag skip: "has side effect"
  test "remove_from_saved_shows/2", %{token: token, show_id: show_id} do
    assert :ok == Library.remove_from_saved_shows(token, ids: [show_id])
  end

  test "check_shows_saved_state/2", %{token: token, show_id: show_id} do
    assert {:ok, [true]} == Library.check_shows_saved_state(token, ids: [show_id])
  end
end
