defmodule Sptfy.Object.SimplifiedPlaylist do
  @moduledoc """
  Module for playlist (simplified) struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Image, Paging, PlaylistTrack, PublicUser}

  defstruct ~w[
    collaborative
    description
    external_urls
    href
    id
    images
    name
    owner
    primary_color
    public
    snapshot_id
    tracks
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)
      |> Map.update(:owner, nil, &PublicUser.new/1)
      |> Map.update(:tracks, %Paging{}, &Paging.new(&1, PlaylistTrack))

    struct(__MODULE__, fields)
  end
end
