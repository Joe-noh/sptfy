defmodule Sptfy.Album do
  use Sptfy.Client

  alias Sptfy.Object.{FullAlbum, Paging, SimplifiedTrack}

  get "/v1/albums",
    as: :get_albums,
    query: [:ids, :market],
    mapping: list_of(FullAlbum, "albums"),
    return_type: [FullAlbum.t()]

  get "/v1/albums/:id",
    as: :get_album,
    query: [:market],
    mapping: single(FullAlbum),
    return_type: FullAlbum.t()

  get "/v1/albums/:id/tracks",
    as: :get_album_tracks,
    query: [:market, :limit, :offset],
    mapping: paged(SimplifiedTrack),
    return_type: Paging.t()
end
