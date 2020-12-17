defmodule Sptfy.Track do
  use Sptfy.Client

  alias Sptfy.Object.{AudioFeature, FullTrack}

  get "/v1/tracks",
    as: :get_tracks,
    query: [:ids, :market],
    mapping: {"tracks", list_of(FullTrack)},
    return_type: [FullTrack.t()]

  get "/v1/audio-features",
    as: :get_audio_features,
    query: [:ids],
    mapping: {"audio_features", list_of(AudioFeature)},
    return_type: [AudioFeature.t()]
end
