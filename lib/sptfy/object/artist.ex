defmodule Sptfy.Object.Artist do
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
