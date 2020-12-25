defmodule IntegrationTest.ArtistTest do
  use ExUnit.Case

  alias Sptfy.Artist
  alias Sptfy.Object.FullArtist

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), artist_id: "0oSGxfWSnnOXhD2fKuz2Gy"}
  end

  test "get_artists/2", %{token: token, artist_id: artist_id} do
    assert {:ok, [%FullArtist{}]} = Artist.get_artists(token, ids: [artist_id])
  end
end
