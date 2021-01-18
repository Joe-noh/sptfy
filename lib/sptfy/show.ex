defmodule Sptfy.Show do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-shows
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullShow, Paging, SimplifiedEpisode, SimplifiedShow}

  get "/v1/shows",
    as: :get_shows,
    query: [:ids, :market],
    mapping: list_of(SimplifiedShow, "shows"),
    return_type: {:ok, [SimplifiedShow.t()]}

  get "/v1/shows/:id",
    as: :get_show,
    query: [:market],
    mapping: single(FullShow),
    return_type: {:ok, FullShow.t()}

  get "/v1/shows/:id/episodes",
    as: :get_episodes,
    query: [:market, :limit, :offset],
    mapping: paged(SimplifiedEpisode),
    return_type: {:ok, Paging.t()}
end
