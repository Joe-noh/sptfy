defmodule Sptfy.PersonalizationTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Personalization
  alias Sptfy.Object.{FullArtist, FullTrack, Paging}

  describe "get_top_artists/2" do
    test "returns a Paging structs" do
      json = Fixtures.paging(Fixtures.full_artist())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/artists", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: [%FullArtist{}]}} = Personalization.get_top_artists("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/artists", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Personalization.get_top_artists("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_top_tracks/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.full_track())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/tracks", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: [%FullTrack{}]}} = Personalization.get_top_tracks("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/top/tracks", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Personalization.get_top_tracks("token", id: "abc")
      end
    end
  end
end
