defmodule IntegrationTest.EpisodeTest do
  use ExUnit.Case

  alias Sptfy.Episode
  alias Sptfy.Object.FullEpisode

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), episode_id: "512ojhOuo1ktJprKbVcKyQ"}
  end

  test "get_episodes/2", %{token: token, episode_id: episode_id} do
    assert {:ok, [%FullEpisode{}]} = Episode.get_episodes(token, ids: [episode_id])
  end

  test "get_episode/2", %{token: token, episode_id: episode_id} do
    assert {:ok, %FullEpisode{}} = Episode.get_episode(token, id: episode_id)
  end
end
