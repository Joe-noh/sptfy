defmodule Sptfy.EpisodeTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Episode
  alias Sptfy.Object.FullEpisode

  describe "get_episodes/2" do
    test "returns list of FullEpisode structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes", _ -> TestHelpers.response(episodes_json()) end do
        assert {:ok, [%FullEpisode{}]} = Episode.get_episodes("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Episode.get_episodes("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_episode/2" do
    test "returns a FullEpisode struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes/abc", _ -> TestHelpers.response(episode_json()) end do
        assert {:ok, %FullEpisode{}} = Episode.get_episode("token", id: "abc")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/episodes/abc", _ -> TestHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Episode.get_episode("token", id: "abc")
      end
    end
  end

  defp episodes_json do
    %{"episodes" => [episode_json()]}
  end

  defp episode_json do
    %{
      "audio_preview_url" => "https://p.scdn.co/mp3-preview/...",
      "description" => "EPISODE DESCRIPTION",
      "duration_ms" => 1_502_795,
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/episode/EPISODE_ID"
      },
      "href" => "https://api.spotify.com/v1/episodes/EPISODE_ID",
      "id" => "EPISODE_ID",
      "images" => [
        %{
          "height" => 640,
          "url" => "https://i.scdn.co/image/...",
          "width" => 640
        },
        %{
          "height" => 300,
          "url" => "https://i.scdn.co/image/...",
          "width" => 300
        },
        %{
          "height" => 64,
          "url" => "https://i.scdn.co/image/...",
          "width" => 64
        }
      ],
      "is_externally_hosted" => false,
      "is_playable" => true,
      "language" => "en",
      "languages" => ["en"],
      "name" => "EPISODE NAME",
      "release_date" => "2015-10-01",
      "release_date_precision" => "day",
      "resume_point" => %{"fully_played" => false, "resume_position_ms" => 0},
      "show" => show_json(),
      "type" => "episode",
      "uri" => "spotify:episode:EPISODE_ID"
    }
  end

  defp show_json do
    %{
      "available_markets" => ["US"],
      "copyrights" => [],
      "description" => "SHOW DESCRIPTION",
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/show/SHOW_ID"
      },
      "href" => "https://api.spotify.com/v1/shows/SHOW_ID",
      "id" => "SHOW_ID",
      "images" => [
        %{
          "height" => 640,
          "url" => "https://i.scdn.co/image/...",
          "width" => 640
        },
        %{
          "height" => 300,
          "url" => "https://i.scdn.co/image/...",
          "width" => 300
        },
        %{
          "height" => 64,
          "url" => "https://i.scdn.co/image/...",
          "width" => 64
        }
      ],
      "is_externally_hosted" => false,
      "languages" => ["en"],
      "media_type" => "audio",
      "name" => "SHOW NAME",
      "publisher" => "SHOW PUBLISHER",
      "total_episodes" => 500,
      "type" => "show",
      "uri" => "spotify:show:SHOW_ID"
    }
  end
end
