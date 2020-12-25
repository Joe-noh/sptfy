defmodule IntegrationTest.TrackTest do
  use ExUnit.Case

  alias Sptfy.Album
  alias Sptfy.Object.FullAlbum

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), album_id: "4eGxY7valsJbD7bX0yUwPM"}
  end

  test "get_albums/2", %{token: token, album_id: album_id} do
    assert {:ok, [%FullAlbum{}]} = Album.get_albums(token, ids: [album_id])
  end
end
