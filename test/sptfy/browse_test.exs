defmodule Sptfy.BrowseTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Browse
  alias Sptfy.Object.{Category, Paging, Recommendation, SimplifiedAlbum, SimplifiedPlaylist}

  describe "get_new_releases/2" do
    test "returns a Paging struct" do
      json = %{"albums" => Fixtures.paging(Fixtures.simplified_album())}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/new-releases", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: albums}} = Browse.get_new_releases("token")
        assert Enum.all?(albums, fn album -> %SimplifiedAlbum{} = album end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/new-releases", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_new_releases("token")
      end
    end
  end

  describe "get_featured_playlists/2" do
    test "returns a Paging struct with message" do
      json = %{"message" => "MESSAGE", "playlists" => Fixtures.paging(Fixtures.simplified_playlist())}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/featured-playlists", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: albums}, "MESSAGE"} = Browse.get_featured_playlists("token")
        assert Enum.all?(albums, fn album -> %SimplifiedPlaylist{} = album end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/featured-playlists", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_featured_playlists("token")
      end
    end
  end

  describe "get_categories/2" do
    test "returns a Paging struct" do
      json = %{"categories" => Fixtures.paging(Fixtures.category())}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: categories}} = Browse.get_categories("token")
        assert Enum.all?(categories, fn category -> %Category{} = category end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_categories("token")
      end
    end
  end

  describe "get_category/2" do
    test "returns a Category struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc", _ -> MockHelpers.response(Fixtures.category()) end do
        assert {:ok, %Category{}} = Browse.get_category("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_category("token", id: "abc")
      end
    end
  end

  describe "get_category_playlists/2" do
    test "returns a Category struct" do
      json = %{"playlists" => Fixtures.paging(Fixtures.simplified_playlist())}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc/playlists", _ -> MockHelpers.response(json) end do
        assert {:ok, %Paging{items: playlists}} = Browse.get_category_playlists("token", id: "abc")
        assert Enum.all?(playlists, fn playlist -> %SimplifiedPlaylist{} = playlist end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/browse/categories/abc/playlists", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_category_playlists("token", id: "abc")
      end
    end
  end

  describe "get_recommendations/2" do
    test "returns a Recommendation struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations", _ -> MockHelpers.response(Fixtures.recommendation()) end do
        assert {:ok, %Recommendation{}} = Browse.get_recommendations("token", seed_artists: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_recommendations("token", seed_artists: ["abc"])
      end
    end
  end

  describe "get_genres/2" do
    test "returns a list of genre names" do
      json = %{"genres" => ["rock"]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations/available-genre-seeds", _ -> MockHelpers.response(json) end do
        assert {:ok, ["rock"]} == Browse.get_genres("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/recommendations/available-genre-seeds", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Browse.get_genres("token")
      end
    end
  end
end
