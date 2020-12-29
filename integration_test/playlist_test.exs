defmodule IntegrationTest.PlaylistTest do
  use ExUnit.Case

  alias Sptfy.Playlist
  alias Sptfy.Object.{Paging, SimplifiedPlaylist}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_my_playlists/2", %{token: token} do
    assert {:ok, %Paging{items: playlists}} = Playlist.get_my_playlists(token)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
  end
end
