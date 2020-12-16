defmodule Sptfy.Track do
  use Sptfy.Client

  alias Sptfy.Object.AudioFeature

  get "/v1/audio-features",
    as: :get_audio_features,
    query: [:ids],
    mapping: {"audio_features", list_of(AudioFeature)},
    return_type: [AudioFeature.t()]
end
