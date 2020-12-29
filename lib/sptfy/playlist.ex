defmodule Sptfy.Playlist do
  use Sptfy.Client

  alias Sptfy.Object.{Paging, SimplifiedPlaylist}

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
end
