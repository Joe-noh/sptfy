defmodule Sptfy.Artist do
  use Sptfy.Client

  alias Sptfy.Object.FullArtist

  get "/v1/artists",
    as: :get_artists,
    query: [:ids],
    mapping: list_of(FullArtist, "artists"),
    return_type: [FullArtist.t()]

  get "/v1/artists/:id",
    as: :get_artist,
    query: [],
    mapping: single(FullArtist),
    return_type: FullArtist.t()
end
