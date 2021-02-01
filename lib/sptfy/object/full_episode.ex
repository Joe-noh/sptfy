defmodule Sptfy.Object.FullEpisode do
  @moduledoc """
  Module for episode (full) struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{Image, ResumePoint, SimplifiedShow}

  defstruct ~w[
    audio_preview_url
    description
    duration_ms
    explicit
    external_urls
    href
    id
    images
    is_externally_hosted
    is_playable
    language
    languages
    name
    release_date
    release_date_precision
    resume_point
    show
    type
    uri
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:images, [], fn images -> Enum.map(images, &Image.new/1) end)
      |> Map.update(:resume_point, nil, &ResumePoint.new/1)
      |> Map.update(:show, nil, &SimplifiedShow.new/1)

    struct(__MODULE__, fields)
  end
end
