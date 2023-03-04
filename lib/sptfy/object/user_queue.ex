defmodule Sptfy.Object.UserQueue do
  @moduledoc """
  Module for the user queue.
  """

  use Sptfy.Object

  alias Sptfy.Object.FullTrack

  defstruct ~w[
    currently_playing
    queue
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:currently_playing, nil, &build_currently_playing(&1))
      |> Map.update(:queue, [], fn items -> Enum.map(items, &FullTrack.new/1) end)

    struct(__MODULE__, fields)
  end

  defp build_currently_playing(_field = nil), do: nil
  defp build_currently_playing(field), do: FullTrack.new(field)
end
