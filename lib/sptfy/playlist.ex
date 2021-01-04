defmodule Sptfy.Playlist do
  use Sptfy.Client

  alias Sptfy.Object.{FullPlaylist, Image, Paging, PlaylistTrack, SimplifiedPlaylist}

  get "/v1/me/playlists",
    as: :get_my_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist),
    return_type: {:ok, Paging.t()}

  get "/v1/users/:id/playlists",
    as: :get_user_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist),
    return_type: {:ok, Paging.t()}

  post "/v1/users/:id/playlists",
    as: :create_user_playlist,
    query: [],
    body: [:name, :public, :collaborative, :description],
    mapping: single(FullPlaylist),
    return_type: {:ok, FullPlaylist.t()}

  get "/v1/playlists/:id",
    as: :get_playlist,
    query: [:market, :fields, :additional_types],
    mapping: single(FullPlaylist),
    return_type: {:ok, FullPlaylist.t()}

  put "/v1/playlists/:id",
    as: :update_playlist_details,
    query: [],
    body: [:name, :public, :collaborative, :description],
    mapping: ok(),
    return_type: :ok

  get "/v1/playlists/:id/tracks",
    as: :get_playlist_tracks,
    query: [:market, :fields, :limit, :offset, :additional_types],
    mapping: paged(PlaylistTrack),
    return_type: {:ok, Paging.t()}

  post "/v1/playlists/:id/tracks",
    as: :add_tracks,
    query: [],
    body: [:uris, :position],
    mapping: ok(),
    return_type: :ok

  put "/v1/playlists/:id/tracks",
    as: :replace_tracks,
    query: [],
    body: [:uris],
    mapping: ok(),
    return_type: :ok

  put "/v1/playlists/:id/tracks",
    as: :reorder_tracks,
    query: [],
    body: [:range_start, :insert_before, :range_length, :snapshot_id],
    mapping: ok(),
    return_type: :ok

  get "/v1/playlists/:id/images",
    as: :get_cover_images,
    query: [],
    mapping: list_of(Image),
    return_type: {:ok, [Image.t()]}

  put_jpeg "/v1/playlists/:id/images",
    as: :upload_cover_image,
    query: [],
    mapping: ok(),
    return_type: :ok

  delete "/v1/playlists/:id/tracks",
    as: :remove_tracks,
    query: [],
    body: [:tracks],
    mapping: ok(),
    return_type: :ok
end
