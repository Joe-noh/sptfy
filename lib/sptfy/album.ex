defmodule Sptfy.Album do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-albums
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullAlbum, SimplifiedTrack}

  get "/v1/albums",
    as: :get_albums,
    query: [{:ids, required: true}, :market],
    mapping: {:list, module: FullAlbum, key: "albums"}

  get "/v1/albums/:id",
    as: :get_album,
    query: [:market],
    mapping: {:single, module: FullAlbum}

  get "/v1/albums/:id/tracks",
    as: :get_album_tracks,
    query: [:market, :limit, :offset],
    mapping: {:paging, module: SimplifiedTrack}
end
