defmodule Sptfy.Episode do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-episodes
  """

  use Sptfy.Client

  alias Sptfy.Object.FullEpisode

  get "/v1/episodes",
    as: :get_episodes,
    query: [:ids, :market],
    mapping: list_of(FullEpisode, "episodes"),
    return_type: {:ok, [FullEpisode.t()]}

  get "/v1/episodes/:id",
    as: :get_episode,
    query: [:market],
    mapping: single(FullEpisode),
    return_type: {:ok, FullEpisode.t()}
end
