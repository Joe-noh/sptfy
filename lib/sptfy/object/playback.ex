defmodule Sptfy.Object.Playback do
  use Sptfy.Object

  alias Sptfy.Object.{Context, Device, FullEpisode, FullTrack}

  defstruct ~w[
    device
    shuffle_state
    repeat_state
    timestamp
    context
    progress_ms
    item
    currently_playing_type
    is_playing
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:device, nil, &Device.new/1)
      |> Map.update(:context, nil, &Context.new/1)
      |> Map.update(:item, nil, &build_item/1)

    struct(__MODULE__, fields)
  end

  defp build_item(fields = %{"type" => "track"}), do: FullTrack.new(fields)
  defp build_item(fields = %{"type" => "episode"}), do: FullEpisode.new(fields)
end
