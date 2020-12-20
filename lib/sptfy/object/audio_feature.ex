defmodule Sptfy.Object.AudioFeature do
  use Sptfy.Object

  defstruct ~w[
    acousticness
    analysis_url
    danceability
    duration_ms
    energy
    id
    instrumentalness
    key
    liveness
    loudness
    mode
    speechiness
    tempo
    time_signature
    track_href
    type
    uri
    valence
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
