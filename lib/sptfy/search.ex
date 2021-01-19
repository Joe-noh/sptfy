defmodule Sptfy.Search do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-search
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, FullTrack, SimplifiedAlbum, SimplifiedEpisode, SimplifiedPlaylist, SimplifiedShow}

  get "/v1/search",
    as: :search_album,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "album"}],
    mapping: {:paging, module: SimplifiedAlbum, key: "albums"}

  get "/v1/search",
    as: :search_artist,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "artist"}],
    mapping: {:paging, module: FullArtist, key: "artists"}

  get "/v1/search",
    as: :search_episode,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "episode"}],
    mapping: {:paging, module: SimplifiedEpisode, key: "episodes"}

  get "/v1/search",
    as: :search_playlist,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "playlist"}],
    mapping: {:paging, module: SimplifiedPlaylist, key: "playlists"}

  get "/v1/search",
    as: :search_show,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "show"}],
    mapping: {:paging, module: SimplifiedShow, key: "shows"}

  get "/v1/search",
    as: :search_track,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "track"}],
    mapping: {:paging, module: FullTrack, key: "tracks"}
end
