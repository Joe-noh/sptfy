defmodule Sptfy.Episode do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-episodes
  """

  use Sptfy.Client

  alias Sptfy.Object.FullEpisode

  get "/v1/episodes",
    as: :get_episodes,
    query: [{:ids, required: true}, :market],
    mapping: {:list, module: FullEpisode, key: "episodes"}

  get "/v1/episodes/:id",
    as: :get_episode,
    query: [:market],
    mapping: {:single, module: FullEpisode}
end
