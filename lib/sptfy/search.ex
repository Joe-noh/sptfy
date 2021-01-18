defmodule Sptfy.Search do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-search
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullArtist, FullTrack, SimplifiedAlbum, SimplifiedEpisode, SimplifiedPlaylist, SimplifiedShow}

  get "/v1/search",
    as: :search_album,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "album"}],
    mapping: paged(SimplifiedAlbum, "albums")

  get "/v1/search",
    as: :search_artist,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "artist"}],
    mapping: paged(FullArtist, "artists")

  get "/v1/search",
    as: :search_episode,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "episode"}],
    mapping: paged(SimplifiedEpisode, "episodes")

  get "/v1/search",
    as: :search_playlist,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "playlist"}],
    mapping: paged(SimplifiedPlaylist, "playlists")

  get "/v1/search",
    as: :search_show,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "show"}],
    mapping: paged(SimplifiedShow, "shows")

  get "/v1/search",
    as: :search_track,
    query: [:q, :market, :limit, :offset, :include_external, {:type, "track"}],
    mapping: paged(FullTrack, "tracks")
end
