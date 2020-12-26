defmodule Sptfy.Show do
  use Sptfy.Client

  alias Sptfy.Object.{FullShow, Paging, SimplifiedEpisode, SimplifiedShow}

  get "/v1/shows",
    as: :get_shows,
    query: [:ids, :market],
    mapping: list_of(SimplifiedShow, "shows"),
    return_type: [SimplifiedShow.t()]

  get "/v1/shows/:id",
    as: :get_show,
    query: [:market],
    mapping: single(FullShow),
    return_type: FullShow.t()

  get "/v1/shows/:id/episodes",
    as: :get_episodes,
    query: [:market, :limit, :offset],
    mapping: paged(SimplifiedEpisode),
    return_type: Paging.t()
end
