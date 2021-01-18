defmodule Sptfy.Playlist do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-playlists
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullPlaylist, Image, PlaylistTrack, SimplifiedPlaylist}

  get "/v1/me/playlists",
    as: :get_my_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist)

  get "/v1/users/:id/playlists",
    as: :get_user_playlists,
    query: [:limit, :offset],
    mapping: paged(SimplifiedPlaylist)

  post "/v1/users/:id/playlists",
    as: :create_user_playlist,
    query: [],
    body: [:name, :public, :collaborative, :description],
    mapping: single(FullPlaylist)

  get "/v1/playlists/:id",
    as: :get_playlist,
    query: [:market, :fields, :additional_types],
    mapping: single(FullPlaylist)

  put "/v1/playlists/:id",
    as: :update_playlist_details,
    query: [],
    body: [:name, :public, :collaborative, :description],
    mapping: ok()

  get "/v1/playlists/:id/tracks",
    as: :get_playlist_tracks,
    query: [:market, :fields, :limit, :offset, :additional_types],
    mapping: paged(PlaylistTrack)

  post "/v1/playlists/:id/tracks",
    as: :add_tracks,
    query: [],
    body: [:uris, :position],
    mapping: ok()

  put "/v1/playlists/:id/tracks",
    as: :replace_tracks,
    query: [],
    body: [:uris],
    mapping: ok()

  put "/v1/playlists/:id/tracks",
    as: :reorder_tracks,
    query: [],
    body: [:range_start, :insert_before, :range_length, :snapshot_id],
    mapping: ok()

  get "/v1/playlists/:id/images",
    as: :get_cover_images,
    query: [],
    mapping: list_of(Image)

  put_jpeg "/v1/playlists/:id/images",
    as: :upload_cover_image,
    query: [],
    mapping: ok()

  delete "/v1/playlists/:id/tracks",
    as: :remove_tracks,
    query: [],
    body: [:tracks],
    mapping: ok()
end
