defmodule Sptfy.Object.Artist do
  @type t :: %__MODULE__{}

  defstruct ~w[
    external_urls
    href
    id
    name
    type
    uri
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
