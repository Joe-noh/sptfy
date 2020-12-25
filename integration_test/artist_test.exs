defmodule IntegrationTest.ArtistTest do
  use ExUnit.Case

  alias Sptfy.Artist
  alias Sptfy.Object.{FullArtist, FullTrack, Paging, SimplifiedAlbum}

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

  test "get_related_artists/2", %{token: token, artist_id: artist_id} do
    assert {:ok, artists} = Artist.get_related_artists(token, id: artist_id)
    assert Enum.all?(artists, fn artist -> %FullArtist{} = artist end)
  end

  test "get_albums/2", %{token: token, artist_id: artist_id} do
    assert {:ok, %Paging{items: items}} = Artist.get_albums(token, id: artist_id)
    assert Enum.all?(items, fn item -> %SimplifiedAlbum{} = item end)
  end
end
