defmodule Sptfy.Personalization do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-personalization
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, FullTrack}

  get "/v1/me/top/artists",
    as: :get_top_artists,
    query: [:time_range, :limit, :offset],
    mapping: paged(FullArtist)

  get "/v1/me/top/tracks",
    as: :get_top_tracks,
    query: [:time_range, :limit, :offset],
    mapping: paged(FullTrack)
end
