defmodule IntegrationTest.BrowseTest do
  use ExUnit.Case

  alias Sptfy.Browse
  alias Sptfy.Object.{Category, Paging, SimplifiedAlbum, SimplifiedPlaylist}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), category_id: "party"}
  end

  test "get_new_releases/2", %{token: token} do
    assert {:ok, %Paging{items: albums}} = Browse.get_new_releases(token)
    assert Enum.all?(albums, fn album -> %SimplifiedAlbum{} = album end)
  end

  test "get_featured_playlists/2", %{token: token} do
    assert {:ok, %Paging{items: playlists}, message} = Browse.get_featured_playlists(token)
    assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
    assert message |> is_binary()
  end

  test "get_categories/2", %{token: token} do
    assert {:ok, %Paging{items: categories}} = Browse.get_categories(token)
    assert Enum.all?(categories, fn category -> %Category{} = category end)
  end

  test "get_category/2", %{token: token, category_id: category_id} do
    assert {:ok, %Category{}} = Browse.get_category(token, id: category_id)
  end
end
