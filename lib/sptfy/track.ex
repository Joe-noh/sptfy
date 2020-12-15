defmodule Sptfy.Track do
  import Sptfy.Client

  get "/v1/audio-features",
    as: :get_audio_features,
    query: [:ids]
end
