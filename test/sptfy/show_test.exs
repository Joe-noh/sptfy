defmodule Sptfy.ShowTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Show
  alias Sptfy.Object.{FullShow, Paging, SimplifiedEpisode, SimplifiedShow}

  describe "get_shows/2" do
    test "returns list of SimplifiedShow structs" do
      json = %{"shows" => [Fixtures.simplified_show()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows", _ -> TestHelpers.response(json) end do
        assert {:ok, [%SimplifiedShow{}]} = Show.get_shows("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Show.get_shows("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_show/2" do
    test "returns a FullShow struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc", _ -> TestHelpers.response(Fixtures.full_show()) end do
        assert {:ok, %FullShow{}} = Show.get_show("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Show.get_show("token", id: "abc")
      end
    end
  end

  describe "get_episodes/2" do
    test "returns a Paging struct" do
      json = Fixtures.paging(Fixtures.simplified_episode())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc/episodes", _ -> TestHelpers.response(json) end do
        assert {:ok, %Paging{items: [%SimplifiedEpisode{}]}} = Show.get_episodes("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc/episodes", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Show.get_episodes("token", id: "abc")
      end
    end
  end
end
