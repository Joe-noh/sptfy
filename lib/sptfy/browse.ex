defmodule Sptfy.Browse do
  use Sptfy.Client

  alias Sptfy.Object.{Category, Paging, SimplifiedAlbum, SimplifiedPlaylist}

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
end
