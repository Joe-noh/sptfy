defmodule Sptfy.Object.SavedTrack do
  @moduledoc """
  Module for saved track struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.FullTrack

  defstruct ~w[
    added_at
    track
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:added_at, nil, &Helpers.parse_timestamp/1)
      |> Map.update(:track, nil, &FullTrack.new/1)

    struct(__MODULE__, fields)
  end
end
