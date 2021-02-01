defmodule Sptfy.Object.FullArtist do
  @moduledoc """
  Module for artist (full) struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Followers, Image}

  defstruct ~w[
    external_urls
    followers
    genres
    href
    id
    images
    name
    popularity
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:followers, nil, &Followers.new/1)
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)

    struct(__MODULE__, fields)
  end
end
