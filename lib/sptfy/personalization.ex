defmodule Sptfy.Personalization do
  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, FullTrack, Paging}

  get "/v1/me/top/artists",
    as: :get_top_artists,
    query: [:time_range, :limit, :offset],
    mapping: paged(FullArtist),
    return_type: Paging.t()

  get "/v1/me/top/tracks",
    as: :get_top_tracks,
    query: [:time_range, :limit, :offset],
    mapping: paged(FullTrack),
    return_type: Paging.t()
end
