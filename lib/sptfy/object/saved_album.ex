defmodule Sptfy.Object.SavedAlbum do
  use Sptfy.Object

  alias Sptfy.Object.FullAlbum

  defstruct ~w[
    added_at
    album
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:album, nil, &FullAlbum.new/1)

    struct(__MODULE__, fields)
  end
end
