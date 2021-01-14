defmodule Sptfy.Browse do
  use Sptfy.Client

  alias Sptfy.Object.{Category, Paging, Recommendation, SimplifiedAlbum, SimplifiedPlaylist}

  get "/v1/browse/new-releases",
    as: :get_new_releases,
    query: [:country, :limit, :offset],
    mapping: paged(SimplifiedAlbum, "albums"),
    return_type: {:ok, Paging.t()}

  get "/v1/browse/featured-playlists",
    as: :get_featured_playlists,
    query: [:country, :locale, :timestamp, :limit, :offset],
    mapping: paged_with_message(SimplifiedPlaylist, "playlists"),
    return_type: {:ok, Paging.t(), String.t()}

  get "/v1/browse/categories",
    as: :get_categories,
    query: [:country, :locale, :timestamp, :limit, :offset],
    mapping: paged(Category, "categories"),
    return_type: {:ok, Paging.t()}

  get "/v1/browse/categories/:id",
    as: :get_category,
    query: [:country, :locale],
    mapping: single(Category),
    return_type: {:ok, Category.t()}

  get "/v1/browse/categories/:id/playlists",
    as: :get_category_playlists,
    query: [:country, :limit, :offset],
    mapping: paged(SimplifiedPlaylist, "playlists"),
    return_type: {:ok, Paging.t()}

  get "/v1/recommendations",
    as: :get_recommendations,
    query: ~w[
      limit
      market
      seed_artists
      seed_genres
      seed_tracks
      min_acousticness
      max_acousticness
      target_acousticness
      min_danceability
      max_danceability
      target_danceability
      min_duration_ms
      max_duration_ms
      target_duration_ms
      min_energy
      max_energy
      target_energy
      min_instrumentalness
      max_instrumentalness
      target_instrumentalness
      min_key
      max_key
      target_key
      min_liveness
      max_liveness
      target_liveness
      min_loudness
      max_loudness
      target_loudness
      min_mode
      max_mode
      target_mode
      min_popularity
      max_popularity
      target_popularity
      min_speechiness
      max_speechiness
      target_speechiness
      min_tempo
      max_tempo
      target_tempo
      min_time_signature
      max_time_signature
      target_time_signature
      min_valence
      max_valence
      target_valence
    ]a,
    mapping: single(Recommendation),
    return_type: {:ok, Recommendation.t()}

  get "/v1/recommendations/available-genre-seeds",
    as: :get_genres,
    query: [],
    mapping: as_is("genres"),
    return_type: {:ok, [String.t()]}
end
