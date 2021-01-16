defmodule Sptfy.Object.Context do
  use Sptfy.Object

  defstruct ~w[
    type
    href
    external_urls
    uri
  ]a
end
