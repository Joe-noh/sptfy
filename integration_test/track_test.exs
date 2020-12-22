defmodule IntegrationTest.TrackTest do
  use ExUnit.Case

  alias Sptfy.Track
  alias Sptfy.Object.{AudioFeature, FullTrack}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), track_id: "3KtsRijwp8KunCRYlOdWEi"}
  end

  test "get_tracks/2", %{token: token, track_id: track_id} do
    assert {:ok, [%FullTrack{}]} = Track.get_tracks(token, ids: [track_id])
  end

  test "get_track/2", %{token: token, track_id: track_id} do
    assert {:ok, %FullTrack{}} = Track.get_track(token, id: track_id)
  end

  test "get_tracks_audio_features/2", %{token: token, track_id: track_id} do
    assert {:ok, [%AudioFeature{}]} = Track.get_tracks_audio_features(token, ids: [track_id])
  end

  test "get_track_audio_features/2", %{token: token, track_id: track_id} do
    assert {:ok, %AudioFeature{}} = Track.get_track_audio_features(token, id: track_id)
  end

  test "get_audio_analysis/2", %{token: token, track_id: track_id} do
    assert {:ok, %{}} = Track.get_audio_analysis(token, id: track_id)
  end
end
