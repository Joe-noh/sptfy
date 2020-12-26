defmodule Sptfy.Object.FullShow do
  use Sptfy.Object

  alias Sptfy.Object.{Copyright, Image, Paging, SimplifiedEpisode}

  defstruct ~w[
    available_markets
    copyrights
    description
    explicit
    episodes
    external_urls
    href
    id
    images
    is_externally_hosted
    languages
    media_type
    name
    publisher
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:copyrights, [], fn copyrights -> Enum.map(copyrights, &Copyright.new/1) end)
      |> Map.update(:episodes, %Paging{}, &Paging.new(&1, SimplifiedEpisode))
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)

    struct(__MODULE__, fields)
  end
end
