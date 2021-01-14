defmodule Sptfy.LibraryTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Library
  alias Sptfy.Object.{Paging, SavedAlbum, SavedShow, SavedTrack}

  describe "get_saved_albums/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.saved_album())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_albums("token")
        assert Enum.all?(items, fn item -> %SavedAlbum{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_albums("token")
      end
    end
  end

  describe "save_albums/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/albums", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.save_albums("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/albums", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.save_albums("token", ids: ["abc"])
      end
    end
  end

  describe "remove_from_saved_albums/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/albums", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.remove_from_saved_albums("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/albums", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.remove_from_saved_albums("token", ids: ["abc"])
      end
    end
  end

  describe "check_albums_saved_state/2" do
    test "returns a list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums/contains", _ -> TestHelpers.response([false]) end do
        assert {:ok, [false]} == Library.check_albums_saved_state("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/albums/contains", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.check_albums_saved_state("token", ids: ["abc"])
      end
    end
  end

  describe "get_saved_tracks/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.saved_track())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_tracks("token")
        assert Enum.all?(items, fn item -> %SavedTrack{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_tracks("token")
      end
    end
  end

  describe "save_tracks/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/tracks", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.save_tracks("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/tracks", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.save_tracks("token", ids: ["abc"])
      end
    end
  end

  describe "remove_from_saved_tracks/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/tracks", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.remove_from_saved_tracks("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/tracks", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.remove_from_saved_tracks("token", ids: ["abc"])
      end
    end
  end

  describe "check_tracks_saved_state/2" do
    test "returns a list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks/contains", _ -> TestHelpers.response([false]) end do
        assert {:ok, [false]} == Library.check_tracks_saved_state("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/tracks/contains", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.check_tracks_saved_state("token", ids: ["abc"])
      end
    end
  end

  describe "get_saved_shows/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.saved_show())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: items}} = Library.get_saved_shows("token")
        assert Enum.all?(items, fn item -> %SavedShow{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.get_saved_shows("token")
      end
    end
  end

  describe "save_shows/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/shows", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.save_shows("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/shows", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.save_shows("token", ids: ["abc"])
      end
    end
  end

  describe "remove_from_saved_shows/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/shows", _, _ -> TestHelpers.response(%{}) end do
        assert :ok == Library.remove_from_saved_shows("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, delete: fn _, "/v1/me/shows", _, _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.remove_from_saved_shows("token", ids: ["abc"])
      end
    end
  end

  describe "check_shows_saved_state/2" do
    test "returns a list of booleans" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows/contains", _ -> TestHelpers.response([false]) end do
        assert {:ok, [false]} == Library.check_shows_saved_state("token", ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/shows/contains", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Library.check_shows_saved_state("token", ids: ["abc"])
      end
    end
  end
end
