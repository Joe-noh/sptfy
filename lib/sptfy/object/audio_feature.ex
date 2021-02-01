defmodule Sptfy.Object.AudioFeature do
  @moduledoc """
  Module for audio feature struct.
  """

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
end
