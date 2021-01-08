defmodule IntegrationTest.SearchTest do
  use ExUnit.Case

  alias Sptfy.Search
  alias Sptfy.Object.{FullArtist, FullTrack, Paging, SimplifiedAlbum, SimplifiedEpisode, SimplifiedPlaylist, SimplifiedShow}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), q: "UK+Rock"}
  end

  test "search_album/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_album(token, q: q)
    assert Enum.all?(items, fn item -> %SimplifiedAlbum{} = item end)
  end

  test "search_artist/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_artist(token, q: q)
    assert Enum.all?(items, fn item -> %FullArtist{} = item end)
  end

  test "search_playlist/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_playlist(token, q: q)
    assert Enum.all?(items, fn item -> %SimplifiedPlaylist{} = item end)
  end

  test "search_episode/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_episode(token, q: q)
    assert Enum.all?(items, fn item -> %SimplifiedEpisode{} = item end)
  end

  test "search_show/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_show(token, q: q)
    assert Enum.all?(items, fn item -> %SimplifiedShow{} = item end)
  end

  test "search_track/2", %{token: token, q: q} do
    assert {:ok, %Paging{items: items}} = Search.search_track(token, q: q)
    assert Enum.all?(items, fn item -> %FullTrack{} = item end)
  end
end
