defmodule Sptfy.Object.PublicUser do
  @moduledoc """
  Module for public user profile struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Followers, Image}

  defstruct ~w[
    display_name
    external_urls
    followers
    href
    id
    images
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
