defmodule Sptfy.Show do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-shows
  """

  use Sptfy.Client

  alias Sptfy.Object.{FullShow, SimplifiedEpisode, SimplifiedShow}

  get "/v1/shows",
    as: :get_shows,
    query: [{:ids, required: true}, :market],
    mapping: {:list, module: SimplifiedShow, key: "shows"}

  get "/v1/shows/:id",
    as: :get_show,
    query: [:market],
    mapping: {:single, module: FullShow}

  get "/v1/shows/:id/episodes",
    as: :get_episodes,
    query: [:market, :limit, :offset],
    mapping: {:paging, module: SimplifiedEpisode}
end
