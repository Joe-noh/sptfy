defmodule Sptfy.Object.SimplifiedArtist do
  @moduledoc """
  Module for artist (simplified) struct.
  """

  use Sptfy.Object

  defstruct ~w[
    external_urls
    href
    id
    name
    type
    uri
  ]a
end
