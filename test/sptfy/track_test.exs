defmodule Sptfy.TrackTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Object.AudioFeature

  describe "get_audio_features/2" do
    test "" do
      with_mock Sptfy.Client.HTTP, [get: fn (_, _, _) -> {:ok, audio_features_json()} end] do
        assert {:ok, [feature = %AudioFeature{}]} = Sptfy.Track.get_audio_features("token", ids: [1, 2, 3])
        assert audio_feature_json() == TestHelpers.stringify_keys(feature)
      end
    end
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
      "duration_ms" => 535223,
      "time_signature" => 4
    }
  end
end
