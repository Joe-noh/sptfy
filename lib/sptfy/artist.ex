defmodule Sptfy.Artist do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-artists
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, FullTrack, SimplifiedAlbum}

  get "/v1/artists",
    as: :get_artists,
    query: [:ids],
    mapping: {:list, module: FullArtist, key: "artists"}

  get "/v1/artists/:id",
    as: :get_artist,
    query: [],
    mapping: {:single, module: FullArtist}

  get "/v1/artists/:id/top-tracks",
    as: :get_top_tracks,
    query: [:market],
    mapping: {:list, module: FullTrack, key: "tracks"}

  get "/v1/artists/:id/related-artists",
    as: :get_related_artists,
    query: [],
    mapping: {:list, module: FullArtist, key: "artists"}

  get "/v1/artists/:id/albums",
    as: :get_albums,
    query: [:include_groups, :market, :limit, :offset],
    mapping: {:paging, module: SimplifiedAlbum}
end
