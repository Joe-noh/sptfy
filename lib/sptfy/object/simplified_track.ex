defmodule Sptfy.Object.SimplifiedTrack do
  @moduledoc """
  Module for track (simplified) struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{SimplifiedArtist, TrackLink, TrackRestriction}

  defstruct ~w[
    artists
    available_markets
    disc_number
    duration_ms
    explicit
    external_urls
    href
    id
    is_local
    is_playable
    linked_from
    name
    preview_url
    restrictions
    track_number
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:artists, [], fn artists -> Enum.map(artists, &SimplifiedArtist.new/1) end)
      |> Map.update(:linked_from, nil, &TrackLink.new/1)
      |> Map.update(:restrictions, nil, &TrackRestriction.new/1)

    struct(__MODULE__, fields)
  end
end
