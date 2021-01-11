defmodule Sptfy.Browse do
  use Sptfy.Client

  alias Sptfy.Object.{Paging, SimplifiedAlbum}

  get "/v1/browse/new-releases",
    as: :get_new_releases,
    query: [:country, :limit, :offset],
    mapping: paged(SimplifiedAlbum, "albums"),
    return_type: {:ok, Paging.t()}
end
