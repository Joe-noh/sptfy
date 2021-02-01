defmodule Sptfy.Object.TrackLink do
  @moduledoc """
  Module for track link struct.
  """

  use Sptfy.Object

  defstruct ~w[
    external_urls
    href
    id
    type
    uri
  ]a
end
