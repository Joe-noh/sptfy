defmodule Sptfy.Follow do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-follow
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, Paging}

  put "/v1/playlists/:id/followers",
    as: :follow_playlist,
    query: [],
    body: [:public],
    mapping: ok(),
    return_type: :ok

  delete "/v1/playlists/:id/followers",
    as: :unfollow_playlist,
    query: [],
    body: [],
    mapping: ok(),
    return_type: :ok

  get "/v1/playlists/:id/followers/contains",
    as: :check_playlist_following_state,
    query: [:ids],
    mapping: as_is(),
    return_type: {:ok, [boolean()]}

  get "/v1/me/following",
    as: :get_my_following_artists,
    query: [:after, :limit, {:type, "artist"}],
    mapping: paged(FullArtist, "artists"),
    return_type: {:ok, Paging.t()}

  put "/v1/me/following",
    as: :follow_users,
    query: [type: "user"],
    body: [:ids],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/following",
    as: :follow_artists,
    query: [type: "artist"],
    body: [:ids],
    mapping: ok(),
    return_type: :ok

  delete "/v1/me/following",
    as: :unfollow_users,
    query: [type: "user"],
    body: [:ids],
    mapping: ok(),
    return_type: :ok

  delete "/v1/me/following",
    as: :unfollow_artists,
    query: [type: "artist"],
    body: [:ids],
    mapping: ok(),
    return_type: :ok

  get "/v1/me/following/contains",
    as: :check_my_user_following_state,
    query: [:ids, {:type, "user"}],
    mapping: as_is(),
    return_type: {:ok, [boolean()]}

  get "/v1/me/following/contains",
    as: :check_my_artist_following_state,
    query: [:ids, {:type, "artist"}],
    mapping: as_is(),
    return_type: {:ok, [boolean()]}
end
