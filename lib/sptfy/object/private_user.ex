defmodule Sptfy.Object.PrivateUser do
  @moduledoc """
  Module for private user profile struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Followers, Image}

  defstruct ~w[
    country
    display_name
    email
    explicit_content
    external_urls
    followers
    href
    id
    images
    product
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
