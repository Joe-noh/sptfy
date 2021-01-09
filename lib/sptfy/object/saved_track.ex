defmodule Sptfy.Object.SavedTrack do
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
      |> Map.update(:track, nil, &FullTrack.new/1)

    struct(__MODULE__, fields)
  end
end
