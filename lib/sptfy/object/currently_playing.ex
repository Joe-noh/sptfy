defmodule Sptfy.Object.CurrentlyPlaying do
  use Sptfy.Object

  alias Sptfy.Object.{Context, FullEpisode, FullTrack}

  defstruct ~w[
    context
    timestamp
    progress_ms
    is_playing
    currently_playing_type
    item
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:context, nil, &Context.new/1)
      |> Map.update(:item, nil, &build_item/1)

    struct(__MODULE__, fields)
  end

  defp build_item(fields = %{"type" => "track"}), do: FullTrack.new(fields)
  defp build_item(fields = %{"type" => "episode"}), do: FullEpisode.new(fields)
end
