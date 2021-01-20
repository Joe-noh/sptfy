defmodule Sptfy.Track do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-tracks
  """

  use Sptfy.Client

  alias Sptfy.Object.{AudioFeature, FullTrack}

  get "/v1/tracks",
    as: :get_tracks,
    query: [{:ids, required: true}, :market],
    mapping: {:list, module: FullTrack, key: "tracks"}

  get "/v1/tracks/:id",
    as: :get_track,
    query: [:market],
    mapping: {:single, module: FullTrack}

  get "/v1/audio-features",
    as: :get_tracks_audio_features,
    query: [{:ids, required: true}],
    mapping: {:list, module: AudioFeature, key: "audio_features"}

  get "/v1/audio-features/:id",
    as: :get_track_audio_features,
    query: [],
    mapping: {:single, module: AudioFeature}

  get "/v1/audio-analysis/:id",
    as: :get_audio_analysis,
    query: [],
    mapping: :as_is,
    return_type: {:ok, map()}
end
