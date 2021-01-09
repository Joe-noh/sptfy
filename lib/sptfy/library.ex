defmodule Sptfy.Library do
  use Sptfy.Client

  alias Sptfy.Object.{Paging, SavedAlbum, SavedShow, SavedTrack}

  get "/v1/me/albums",
    as: :get_saved_albums,
    query: [:limit, :offset, :market],
    mapping: paged(SavedAlbum),
    return_type: {:ok, Paging.t()}

  get "/v1/me/tracks",
    as: :get_saved_tracks,
    query: [:limit, :offset, :market],
    mapping: paged(SavedTrack),
    return_type: {:ok, Paging.t()}

  get "/v1/me/shows",
    as: :get_saved_shows,
    query: [:limit, :offset],
    mapping: paged(SavedShow),
    return_type: {:ok, Paging.t()}
end