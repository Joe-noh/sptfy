defmodule Sptfy.Library do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-library
  """

  use Sptfy.Client

  alias Sptfy.Object.{SavedAlbum, SavedShow, SavedTrack}

  get "/v1/me/albums",
    as: :get_saved_albums,
    query: [:limit, :offset, :market],
    mapping: {:paging, module: SavedAlbum}

  put "/v1/me/albums",
    as: :save_albums,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  delete "/v1/me/albums",
    as: :remove_from_saved_albums,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  get "/v1/me/albums/contains",
    as: :check_albums_saved_state,
    query: [{:ids, required: true}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}

  get "/v1/me/tracks",
    as: :get_saved_tracks,
    query: [:limit, :offset, :market],
    mapping: {:paging, module: SavedTrack}

  put "/v1/me/tracks",
    as: :save_tracks,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  delete "/v1/me/tracks",
    as: :remove_from_saved_tracks,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  get "/v1/me/tracks/contains",
    as: :check_tracks_saved_state,
    query: [{:ids, required: true}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}

  get "/v1/me/shows",
    as: :get_saved_shows,
    query: [:limit, :offset],
    mapping: {:paging, module: SavedShow}

  put "/v1/me/shows",
    as: :save_shows,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  delete "/v1/me/shows",
    as: :remove_from_saved_shows,
    query: [],
    body: [{:ids, required: true}],
    mapping: :ok

  get "/v1/me/shows/contains",
    as: :check_shows_saved_state,
    query: [{:ids, required: true}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}
end
