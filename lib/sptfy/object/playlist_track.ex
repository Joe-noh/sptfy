defmodule Sptfy.Object.PlaylistTrack do
  @moduledoc """
  Module for playlist item struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.{FullEpisode, FullTrack, PublicUser}

  defstruct ~w[
    added_at
    added_by
    is_local
    track
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:added_at, nil, &Helpers.parse_timestamp/1)
      |> Map.update(:added_by, nil, &PublicUser.new/1)
      |> Map.update(:track, nil, &build_track/1)

    struct(__MODULE__, fields)
  end

  defp build_track(fields = %{"type" => "track"}), do: FullTrack.new(fields)
  defp build_track(fields = %{"type" => "episode"}), do: FullEpisode.new(fields)
end
