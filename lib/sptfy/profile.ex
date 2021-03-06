defmodule Sptfy.Profile do
  @moduledoc """
  https://developer.spotify.com/documentation/web-api/reference-beta/#category-users-profile
  """

  use Sptfy.Client

  alias Sptfy.Object.{PrivateUser, PublicUser}

  get "/v1/me",
    as: :get_my_profile,
    query: [],
    mapping: {:single, module: PrivateUser}

  get "/v1/users/:id",
    as: :get_profile,
    query: [],
    mapping: {:single, module: PublicUser}
end
