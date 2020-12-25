defmodule Sptfy.Artist do
  use Sptfy.Client

  alias Sptfy.Object.FullArtist

  get "/v1/artists",
    as: :get_artists,
    query: [:ids, :market],
    mapping: list_of(FullArtist, "artists"),
    return_type: [FullArtist.t()]
end
