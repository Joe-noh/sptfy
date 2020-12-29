defmodule Sptfy.Playlist do
  use Sptfy.Client

  alias Sptfy.Object.{FullPlaylist, Paging, SimplifiedPlaylist}

  get "/v1/me/playlists",
    as: :get_my_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist),
    return_type: Paging.t()

  get "/v1/users/:id/playlists",
    as: :get_user_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist),
    return_type: Paging.t()

  get "/v1/playlists/:id",
    as: :get_playlist,
    query: [:market, :fields, :additional_types],
    mapping: single(FullPlaylist),
    return_type: FullPlaylist.t()
end
