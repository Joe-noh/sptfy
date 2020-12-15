defmodule Sptfy.Track do
  import Sptfy.Client
  import Sptfy.Client.ResponseMapper

  get "/v1/audio-features",
    as: :get_audio_features,
    query: [:ids],
    mapping: %{"audio_features" => list_of(Sptfy.Object.AudioFeature)}
end
