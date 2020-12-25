defmodule IntegrationTest.ArtistTest do
  use ExUnit.Case

  alias Sptfy.Artist
  alias Sptfy.Object.{FullArtist, FullTrack}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), artist_id: "0oSGxfWSnnOXhD2fKuz2Gy"}
  end

  test "get_artists/2", %{token: token, artist_id: artist_id} do
    assert {:ok, [%FullArtist{}]} = Artist.get_artists(token, ids: [artist_id])
  end

  test "get_artist/2", %{token: token, artist_id: artist_id} do
    assert {:ok, %FullArtist{}} = Artist.get_artist(token, id: artist_id)
  end

  test "get_top_tracks/2", %{token: token, artist_id: artist_id} do
    assert {:ok, tracks} = Artist.get_top_tracks(token, id: artist_id, market: "US")
    assert Enum.all?(tracks, fn track -> %FullTrack{} = track end)
  end
end
