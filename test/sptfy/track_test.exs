defmodule Sptfy.TrackTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Track
  alias Sptfy.Object.{AudioFeature, FullTrack}

  describe "get_tracks/2" do
    test "returns list of Track structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/tracks", _ -> TestHelpers.response(tracks_json()) end do
        assert {:ok, [%FullTrack{}]} = Track.get_tracks("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_track/2" do
    test "returns a Track struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/track/abc", _ -> TestHelpers.response(track_json()) end do
        assert {:ok, %FullTrack{}} = Track.get_track("token", id: "abc")
      end
    end
  end

  describe "get_tracks_audio_features/2" do
    test "returns list of AudioFeature structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-features", _ -> TestHelpers.response(audio_features_json()) end do
        assert {:ok, [%AudioFeature{}]} = Track.get_tracks_audio_features("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_track_audio_features/2" do
    test "returns list of AudioFeature structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-features/abc", _ -> TestHelpers.response(audio_feature_json()) end do
        assert {:ok, %AudioFeature{}} = Track.get_track_audio_features("token", id: "abc")
      end
    end
  end

  describe "get_audio_analysis/2" do
    test "returns audio structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-analysis/abc", _ -> TestHelpers.response(%{"bars" => []}) end do
        assert {:ok, %{"bars" => []}} = Track.get_audio_analysis("token", id: "abc")
      end
    end
  end

  defp tracks_json do
    %{"tracks" => [track_json()]}
  end

  defp track_json do
    %{
      "album" => %{
        "album_type" => "single",
        "artists" => [
          %{
            "external_urls" => %{
              "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
            },
            "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
            "id" => "ARTIST_ID",
            "name" => "ARTIST NAME",
            "type" => "artist",
            "uri" => "spotify:artist:ARTIST_ID"
          }
        ],
        "available_markets" => ["US"],
        "external_urls" => %{
          "spotify" => "https://open.spotify.com/album/ALBUM_ID"
        },
        "href" => "https://api.spotify.com/v1/albums/ALBUM_ID",
        "id" => "ALBUM_ID",
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
        "name" => "ALBUM NAME",
        "release_date" => "2017-05-26",
        "release_date_precision" => "day",
        "type" => "album",
        "uri" => "spotify:album:ALBUM_ID"
      },
      "artists" => [
        %{
          "external_urls" => %{
            "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
          },
          "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
          "id" => "ARTIST_ID",
          "name" => "ARTIST NAME",
          "type" => "artist",
          "uri" => "spotify:artist:ARTIST_ID"
        }
      ],
      "available_markets" => ["US"],
      "disc_number" => 1,
      "duration_ms" => 207_959,
      "explicit" => false,
      "external_ids" => %{
        "isrc" => "ISRC"
      },
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/track/TRACK_ID"
      },
      "href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "id" => "TRACK_ID",
      "is_local" => false,
      "name" => "TRACK NAME",
      "popularity" => 63,
      "preview_url" => "https://p.scdn.co/mp3-preview/...",
      "track_number" => 1,
      "type" => "track",
      "uri" => "spotify:track:TRACK_ID"
    }
  end

  defp audio_features_json do
    %{"audio_features" => [audio_feature_json()]}
  end

  defp audio_feature_json do
    %{
      "danceability" => 0.808,
      "energy" => 0.626,
      "key" => 7,
      "loudness" => -12.733,
      "mode" => 1,
      "speechiness" => 0.168,
      "acousticness" => 0.00187,
      "instrumentalness" => 0.159,
      "liveness" => 0.376,
      "valence" => 0.369,
      "tempo" => 123.99,
      "type" => "audio_features",
      "id" => "TRACK_ID",
      "uri" => "spotify:track:TRACK_ID",
      "track_href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "analysis_url" => "http://echonest-analysis.s3.amazonaws.com/TR/.../full.json",
      "duration_ms" => 535_223,
      "time_signature" => 4
    }
  end
end
