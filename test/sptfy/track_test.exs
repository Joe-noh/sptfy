defmodule Sptfy.TrackTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Track
  alias Sptfy.Object.{AudioFeature, FullTrack}

  describe "get_tracks/2" do
    test "returns list of Track structs" do
      json = %{"tracks" => [Fixtures.full_track()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/tracks", _ -> MockHelpers.response(json) end do
        assert {:ok, [%FullTrack{}]} = Track.get_tracks("token", ids: [1, 2, 3])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/tracks", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Track.get_tracks("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_track/2" do
    test "returns a Track struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/tracks/abc", _ -> MockHelpers.response(Fixtures.full_track()) end do
        assert {:ok, %FullTrack{}} = Track.get_track("token", id: "abc")
      end
    end
  end

  describe "get_tracks_audio_features/2" do
    test "returns list of AudioFeature structs" do
      json = %{"audio_features" => [Fixtures.audio_feature()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-features", _ -> MockHelpers.response(json) end do
        assert {:ok, [%AudioFeature{}]} = Track.get_tracks_audio_features("token", ids: [1, 2, 3])
      end
    end
  end

  describe "get_track_audio_features/2" do
    test "returns list of AudioFeature structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-features/abc", _ -> MockHelpers.response(Fixtures.audio_feature()) end do
        assert {:ok, %AudioFeature{}} = Track.get_track_audio_features("token", id: "abc")
      end
    end
  end

  describe "get_audio_analysis/2" do
    test "returns audio structs" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/audio-analysis/abc", _ -> MockHelpers.response(%{"bars" => []}) end do
        assert {:ok, %{"bars" => []}} = Track.get_audio_analysis("token", id: "abc")
      end
    end
  end
end
