defmodule Sptfy.Object.TrackLink do
  use Sptfy.Object

  defstruct ~w[
    external_urls
    href
    id
    type
    uri
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
