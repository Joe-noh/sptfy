defmodule Sptfy.Follow do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-follow
  """

  use Sptfy.Client

  alias Sptfy.Object.FullArtist

  put "/v1/playlists/:id/followers",
    as: :follow_playlist,
    query: [],
    body: [:public],
    mapping: :ok

  delete "/v1/playlists/:id/followers",
    as: :unfollow_playlist,
    query: [],
    body: [],
    mapping: :ok

  get "/v1/playlists/:id/followers/contains",
    as: :check_playlist_following_state,
    query: [{:ids, required: true}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}

  get "/v1/me/following",
    as: :get_my_following_artists,
    query: [:after, :limit, {:type, fixed: "artist"}],
    mapping: {:paging, module: FullArtist, key: "artists"}

  put "/v1/me/following",
    as: :follow_users,
    query: [{:type, fixed: "user"}],
    body: [{:ids, required: true}],
    mapping: :ok

  put "/v1/me/following",
    as: :follow_artists,
    query: [{:type, fixed: "artist"}],
    body: [{:ids, required: true}],
    mapping: :ok

  delete "/v1/me/following",
    as: :unfollow_users,
    query: [{:type, fixed: "user"}],
    body: [{:ids, required: true}],
    mapping: :ok

  delete "/v1/me/following",
    as: :unfollow_artists,
    query: [{:type, fixed: "artist"}],
    body: [{:ids, required: true}],
    mapping: :ok

  get "/v1/me/following/contains",
    as: :check_my_user_following_state,
    query: [{:ids, required: true}, {:type, fixed: "user"}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}

  get "/v1/me/following/contains",
    as: :check_my_artist_following_state,
    query: [{:ids, required: true}, {:type, fixed: "artist"}],
    mapping: :as_is,
    return_type: {:ok, [boolean()]}
end
