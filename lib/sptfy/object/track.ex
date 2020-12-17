defmodule Sptfy.Object.Track do
  @type t :: %__MODULE__{}

  defstruct ~w[
    album
    artists
    available_markets
    disc_number
    duration_ms
    explicit
    external_ids
    external_urls
    href
    id
    is_playable
    linked_from
    restrictions
    name
    popularity
    preview_url
    track_number
    type
    uri
    is_local
  ]a
end
