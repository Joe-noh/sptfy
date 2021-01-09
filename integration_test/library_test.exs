defmodule IntegrationTest.LibraryTest do
  use ExUnit.Case

  alias Sptfy.Library
  alias Sptfy.Object.{Paging, SavedAlbum, SavedShow, SavedTrack}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_saved_albums/2", %{token: token} do
    assert {:ok, %Paging{items: albums}} = Library.get_saved_albums(token)
    assert Enum.all?(albums, fn album -> %SavedAlbum{} = album end)
  end

  test "get_saved_tracks/2", %{token: token} do
    assert {:ok, %Paging{items: tracks}} = Library.get_saved_tracks(token)
    assert Enum.all?(tracks, fn track -> %SavedTrack{} = track end)
  end

  test "get_saved_shows/2", %{token: token} do
    assert {:ok, %Paging{items: shows}} = Library.get_saved_shows(token)
    assert Enum.all?(shows, fn show -> %SavedShow{} = show end)
  end
end
