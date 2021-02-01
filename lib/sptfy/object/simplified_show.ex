defmodule Sptfy.Object.SimplifiedShow do
  @moduledoc """
  Module for show (simplified) struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Copyright, Image}

  defstruct ~w[
    available_markets
    copyrights
    description
    explicit
    external_urls
    href
    id
    images
    is_externally_hosted
    languages
    media_type
    name
    publisher
    total_episodes
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:copyrights, [], fn copyrights -> Enum.map(copyrights, &Copyright.new/1) end)
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)

    struct(__MODULE__, fields)
  end
end
