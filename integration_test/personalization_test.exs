defmodule IntegrationTest.PersonalizationTest do
  use ExUnit.Case

  alias Sptfy.Personalization
  alias Sptfy.Object.{FullArtist, FullTrack, Paging, SimplifiedAlbum}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_top_artists/2", %{token: token} do
    assert {:ok, %Paging{items: artists}} = Personalization.get_top_artists(token, time_range: "medium_term")
    assert Enum.all?(artists, fn artist -> %FullArtist{} = artist end)
  end

  test "get_top_tracks/2", %{token: token} do
    assert {:ok, %Paging{items: tracks}} = Personalization.get_top_tracks(token, time_range: "medium_term")
    assert Enum.all?(tracks, fn track -> %FullTrack{} = track end)
  end
end
