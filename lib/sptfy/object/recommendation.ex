defmodule Sptfy.Object.Recommendation do
  @moduledoc """
  Module for recommendation struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{RecommendationSeed, SimplifiedTrack}

  defstruct ~w[
    seeds
    tracks
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:seeds, [], fn seeds -> Enum.map(seeds, &RecommendationSeed.new/1) end)
      |> Map.update(:tracks, [], fn tracks -> Enum.map(tracks, &SimplifiedTrack.new/1) end)

    struct(__MODULE__, fields)
  end
end
