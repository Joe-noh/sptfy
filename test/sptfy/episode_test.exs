defmodule Sptfy.EpisodeTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Episode
  alias Sptfy.Object.FullEpisode

  describe "get_episodes/2" do
    test "returns list of FullEpisode structs" do
      json = %{"episodes" => [Fixtures.full_episode()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes", _ -> MockHelpers.response(json) end do
        assert {:ok, [%FullEpisode{}]} = Episode.get_episodes("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Episode.get_episodes("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_episode/2" do
    test "returns a FullEpisode struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes/abc", _ -> MockHelpers.response(Fixtures.full_episode()) end do
        assert {:ok, %FullEpisode{}} = Episode.get_episode("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes/abc", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Episode.get_episode("token", id: "abc")
      end
    end
  end
end
