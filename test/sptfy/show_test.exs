defmodule Sptfy.ShowTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Show
  alias Sptfy.Object.{FullShow, Paging, SimplifiedEpisode, SimplifiedShow}

  describe "get_shows/2" do
    test "returns list of SimplifiedShow structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows", _ -> TestHelpers.response(simplified_shows_json()) end do
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
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc", _ -> TestHelpers.response(full_show_json()) end do
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
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/shows/abc/episodes", _ -> TestHelpers.response(paging_episodes_json()) end do
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

  defp simplified_shows_json do
    %{"shows" => [simplified_show_json()]}
  end

  defp simplified_show_json do
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

  defp full_show_json do
    %{
      "available_markets" => ["US"],
      "copyrights" => [],
      "description" => "SHOW DESCRIPTION",
      "episodes" => paging_episodes_json(),
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
      "show" => simplified_show_json(),
      "type" => "episode",
      "uri" => "spotify:episode:EPISODE_ID"
    }
  end

  defp paging_episodes_json do
    %{
      "href" => "https://api.spotify.com/v1/shows/SHOW_ID/episodes?offset=0&limit=50",
      "items" => [episode_json()],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end
end
