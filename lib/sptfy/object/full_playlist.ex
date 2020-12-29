defmodule Sptfy.Object.FullPlaylist do
  use Sptfy.Object

  alias Sptfy.Object.{Followers, Image, Paging, PlaylistTrack, PublicUser}

  defstruct ~w[
    collaborative
    description
    external_urls
    followers
    href
    id
    images
    name
    owner
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
      |> Map.update(:followers, nil, &Followers.new/1)
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)
      |> Map.update(:owner, nil, &PublicUser.new/1)
      |> Map.update(:tracks, %Paging{}, &Paging.new(&1, PlaylistTrack))

    struct(__MODULE__, fields)
  end
end
