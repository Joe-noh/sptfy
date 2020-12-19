defmodule Sptfy.Track do
  use Sptfy.Client

  alias Sptfy.Object.{AudioFeature, FullTrack}

  get "/v1/tracks",
    as: :get_tracks,
    query: [:ids, :market],
    mapping: {"tracks", list_of(FullTrack)},
    return_type: [FullTrack.t()]

  get "/v1/track/:id",
    as: :get_track,
    query: [:market],
    mapping: single(FullTrack),
    return_type: FullTrack.t()

  get "/v1/audio-features",
    as: :get_tracks_audio_features,
    query: [:ids],
    mapping: {"audio_features", list_of(AudioFeature)},
    return_type: [AudioFeature.t()]

  get "/v1/audio-features/:id",
    as: :get_track_audio_features,
    query: [],
    mapping: single(AudioFeature),
    return_type: AudioFeature.t()

  get "/v1/audio-analysis/:id",
    as: :get_audio_analysis,
    query: [],
    mapping: as_is(),
    return_type: map()
end
