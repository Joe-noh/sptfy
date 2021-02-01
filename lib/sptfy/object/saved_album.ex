defmodule Sptfy.Object.SavedAlbum do
  @moduledoc """
  Module for saved album struct.
  """

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
      |> Map.update(:added_at, nil, &Helpers.parse_timestamp/1)
      |> Map.update(:album, nil, &FullAlbum.new/1)

    struct(__MODULE__, fields)
  end
end
