defmodule IntegrationTest.BrowseTest do
  use ExUnit.Case

  alias Sptfy.Browse
  alias Sptfy.Object.{Paging, SimplifiedAlbum}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_new_releases/2", %{token: token} do
    assert {:ok, %Paging{items: albums}} = Browse.get_new_releases(token)
    assert Enum.all?(albums, fn album -> %SimplifiedAlbum{} = album end)
  end
end
