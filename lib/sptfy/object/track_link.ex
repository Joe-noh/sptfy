defmodule Sptfy.Object.TrackLink do
  use Sptfy.Object

  defstruct ~w[
    external_urls
    href
    id
    type
    uri
  ]a
end
