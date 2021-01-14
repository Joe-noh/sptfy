defmodule Sptfy.SearchTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Search
  alias Sptfy.Object.{FullArtist, FullTrack, Paging, SimplifiedAlbum, SimplifiedEpisode, SimplifiedPlaylist, SimplifiedShow}

  describe "search_album/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("albums")) end do
        assert {:ok, %Paging{items: [%SimplifiedAlbum{}]}} = Search.search_album("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_album("token", q: "q")
      end
    end
  end

  describe "search_artist/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("artists")) end do
        assert {:ok, %Paging{items: [%FullArtist{}]}} = Search.search_artist("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_artist("token", q: "q")
      end
    end
  end

  describe "search_playlist/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("playlists")) end do
        assert {:ok, %Paging{items: [%SimplifiedPlaylist{}]}} = Search.search_playlist("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_playlist("token", q: "q")
      end
    end
  end

  describe "search_episode/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("episodes")) end do
        assert {:ok, %Paging{items: [%SimplifiedEpisode{}]}} = Search.search_episode("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_episode("token", q: "q")
      end
    end
  end

  describe "search_show/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("shows")) end do
        assert {:ok, %Paging{items: [%SimplifiedShow{}]}} = Search.search_show("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_show("token", q: "q")
      end
    end
  end

  describe "search_track/2" do
    test "returns a Paging struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(paging_json("tracks")) end do
        assert {:ok, %Paging{items: [%FullTrack{}]}} = Search.search_track("token", q: "q")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/search", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Search.search_track("token", q: "q")
      end
    end
  end

  defp paging_json(key) do
    %{key => Fixtures.paging(%{})}
  end
end
