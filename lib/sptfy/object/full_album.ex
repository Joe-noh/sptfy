defmodule Sptfy.Object.FullAlbum do
  use Sptfy.Object

  alias Sptfy.Object.{AlbumRestriction, Copyright, Image, Paging, SimplifiedArtist, SimplifiedTrack}

  defstruct ~w[
    album_type
    artists
    available_markets
    copyrights
    external_ids
    external_urls
    genres
    href
    id
    images
    label
    name
    popularity
    release_date
    release_date_precision
    restrictions
    total_tracks
    tracks
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:artists, [], fn artists -> Enum.map(artists, &SimplifiedArtist.new/1) end)
      |> Map.update(:copyrights, [], fn copyrights -> Enum.map(copyrights, &Copyright.new/1) end)
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)
      |> Map.update(:restrictions, nil, &AlbumRestriction.new/1)
      |> Map.update(:tracks, %Paging{}, &Paging.new(&1, SimplifiedTrack))

    struct(__MODULE__, fields)
  end
end
